//
//  ContentView.swift
//  InvadersLosses
//
//  Created by Andrii Hlybchenko on 27.08.2023.
//

import SwiftUI
import CoreData

struct EquipmentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var equipmentRecords: [EquipmentLossesModel] = []
    @State private var personnelsRecords: [PersonnelLossesModel] = []
    
    let urlLossesEquipment : String = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_equipment.json"
    
    let urlLossesPersonnel : String = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_personnel.json"

    var body: some View {
        TabView {
            defaultViewPresent(navTitle: "Equioment Losses",
                               urlDataAdress: urlLossesEquipment)
            .tabItem {
                Image(systemName: "circle")
                Text("Equipment")
            }

            defaultViewPresent(navTitle: "Personnel Losses",
                               urlDataAdress: urlLossesPersonnel)
            .tabItem {
                Image(systemName: "list.bullet")
                Text("Personnel")
            }
        }
    }
    
    private func defaultViewPresent (navTitle: String, urlDataAdress: String) -> AnyView {
                                        
        return AnyView(
            NavigationView {
                VStack {
                    equipmentRecords.isEmpty
                    ? AnyView(
                        VStack {
                            Text("Connection error")
                            Button("Reload", action: {
                                loadRecords(urlAddressOfData: urlDataAdress)
                            }).buttonStyle(.bordered)
                        }
                    )
                    : AnyView(
                        navTitle == "Equioment Losses"
                        ? cellsEquipView(equipmentRecords: equipmentRecords)
                        : cellsPersonsView(personnelsRecords: personnelsRecords)
                    )}
                .navigationTitle(navTitle)
                .onAppear{loadRecords(urlAddressOfData: urlDataAdress)}
            })
    }
    
    private func cellsEquipView(equipmentRecords: [EquipmentLossesModel]) -> AnyView {
        return AnyView(
            List {
                ForEach(equipmentRecords) { record in
                    OneEquipCellView(oneRecordEquip: record)
                }
            })
    }
    
    private func cellsPersonsView(personnelsRecords: [PersonnelLossesModel]) -> AnyView {
        return AnyView(
            List {
                ForEach(personnelsRecords) { record in
                    OnePersonCellView(oneRecordPerson: record)
                }
            })
    }
    
    private func loadRecords(urlAddressOfData: String) {
        UrlLoadService.shared.fetchEquipJsonFromUrl (urlAddress: urlAddressOfData) { fetchedRecords in
                if let fetchedRecords = fetchedRecords {
                    DispatchQueue.main.async {
                        self.equipmentRecords = fetchedRecords.sorted { $0.date < $1.date }
                    }
                }
            }
        }
}

struct EquipmentView_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentView()
            .environment(\.managedObjectContext,
                          PersistenceController.preview.container.viewContext)
    }
}
