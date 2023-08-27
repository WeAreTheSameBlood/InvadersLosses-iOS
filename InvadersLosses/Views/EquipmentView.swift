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
    
    @State private var searchText: String = ""
    
    @State private var equipmentRecords: [EquipmentLossesModel] = []
    @State private var personnelsRecords: [PersonnelLossesModel] = []
    
    let urlLossesEquipment: String = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_equipment.json"
    
    let urlLossesPersonnel: String = "https://raw.githubusercontent.com/MacPaw/2022-Ukraine-Russia-War-Dataset/main/data/russia_losses_personnel.json"

    var body: some View {
        TabView {
            defaultViewPresent(navTitle: "Equioment Losses",
                               urlDataAdress: urlLossesEquipment)
            .tabItem {
                Image(systemName: "list.star")
                Text("Equipment")
            }

            defaultViewPresent(navTitle: "Personnel Losses",
                               urlDataAdress: urlLossesPersonnel)
            .tabItem {
                Image(systemName: "person.3.sequence.fill")
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
                            Button("Reload", action: { loadRecords() })
                                .buttonStyle(.bordered)
                        }
                    )
                    : AnyView(
                        navTitle == "Equioment Losses"
                        ? cellsEquipView(equipmentRecords: equipmentRecords)
                        : cellsPersonsView(personnelsRecords: personnelsRecords)
                    )}
                .navigationTitle(navTitle)
                .onAppear{loadRecords()}
            })
    }
    
    private func cellsEquipView(equipmentRecords: [EquipmentLossesModel]) -> AnyView {
        return AnyView(
            Group {
                TextField("Search by date or day...", text: $searchText)
                    .padding(5)
                    .background(Color.gray.opacity(1/5))
                    .cornerRadius(8)
                    .padding(.horizontal)
                List {
                    ForEach(filteredEquipmentRecords()) { record in
                        OneEquipCellView(oneRecordEquip: record)
                    }
                }
            })
    }
    
    private func cellsPersonsView(personnelsRecords: [PersonnelLossesModel]) -> AnyView {
        return AnyView(
            Group {
                TextField("Search by date or day...", text: $searchText)
                    .padding(5)
                    .background(Color.gray.opacity(1/5))
                    .cornerRadius(8)
                    .padding(.horizontal)
                List {
                    ForEach(filteredPersonnelsRecords()) { record in
                        OnePersonCellView(oneRecordPerson: record)
                    }
                }
            })
    }
    
    private func loadRecords() {
        UrlLoadService.shared.fetchEquipJsonFromUrl (urlAddress: urlLossesEquipment) { fetchedRecords in
                if let fetchedRecords = fetchedRecords {
                    DispatchQueue.main.async {
                        self.equipmentRecords = fetchedRecords.sorted { $0.date < $1.date }
                        
                    }
                }
            }
        UrlLoadService.shared.fetchPersonsJsonFromUrl (urlAddress: urlLossesPersonnel) { fetchedRecords in
                if let fetchedRecords = fetchedRecords {
                    DispatchQueue.main.async {
                        self.personnelsRecords = fetchedRecords.sorted { $0.date < $1.date }
                        
                    }
                }
            }
        }
    
    func filteredEquipmentRecords() -> [EquipmentLossesModel] {
        return searchText == "" ? equipmentRecords : equipmentRecords.filter {
            $0.date.contains(searchText) || "\($0.day)".contains(searchText)
        }
    }

    func filteredPersonnelsRecords() -> [PersonnelLossesModel] {
        return searchText == "" ? personnelsRecords : personnelsRecords.filter {
            $0.date.contains(searchText) || "\($0.day)".contains(searchText)
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
