//
//  ContentView.swift
//  InvadersLosses
//
//  Created by Andrii Hlybchenko on 27.08.2023.
//

import SwiftUI
import CoreData

struct GeneralView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var searchText: String = ""
    @State private var isSorted: Bool = true
    
    @State private var equipmentRecords: [EquipmentLossesModel] = []
    @State private var personnelsRecords: [PersonnelLossesModel] = []
    @State private var oryxRecords: [OryxLossesModel] = []
    


    var body: some View {
        TabView {
            defaultViewPresent(navTitle: "Equipment Losses", urlDataAdress: ConstURLs.urlLossesEquipment)
                .tabItem {
                    Image(systemName: "list.star")
                    Text("Equipment")
                }

            defaultViewPresent(navTitle: "Personnel Losses", urlDataAdress: ConstURLs.urlLossesPersonnel)
                .tabItem {
                    Image(systemName: "person.3.sequence.fill")
                    Text("Personnel")
                }
            
            defaultViewPresent(navTitle: "Equipment By Oryx", urlDataAdress: ConstURLs.urlLossesEqOryx)
                .tabItem {
                    Image(systemName: "steeringwheel.slash")
                    Text("By Oryx")
                }
        }
    }
    
    private func defaultViewPresent (navTitle: String, urlDataAdress: String) -> AnyView {
                                        
        return AnyView(
            NavigationView {
                VStack {
                    equipmentRecords.isEmpty || personnelsRecords.isEmpty
                    ? AnyView(
                        VStack {
                            Text("Connection error")
                            Button("Reload", action: { loadRecords() })
                                .buttonStyle(.bordered)
                        }
                    )
                    : contentView(navTitle: navTitle)
                }
                .navigationTitle(navTitle)
                .onAppear{loadRecords()}
            })
    }
    
    private func contentView(navTitle: String) -> AnyView {
        switch navTitle {
        case "Equipment Losses":
            return AnyView(cellsEquipView(equipmentRecords: equipmentRecords))
        case "Personnel Losses":
            return AnyView(cellsPersonsView(personnelsRecords: personnelsRecords))
        default:
            return AnyView(cellsOryxView(oryxRecords: oryxRecords))
        }
    }

    private func cellsEquipView(equipmentRecords: [EquipmentLossesModel]) -> AnyView {
        return AnyView(
            Group {
                HStack{
                    TextField("Search by date or day...", text: $searchText)
                        .padding(5)
                        .background(Color.gray.opacity(1/5))
                        .cornerRadius(8)
                        .padding(.leading)
                    
                    Button(action: {
                        isSorted.toggle()
                    }, label: {
                        HStack {
                            Text("Sort by Date")
                            Image(systemName: isSorted ? "arrow.up" : "arrow.down").imageScale(.small)
                        }
                    })
                    .padding(5)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.trailing)
                }.padding(5)
                List {
                    ForEach(filteredEquipmentRecords()) { record in
                        OneEquipCellView(oneRecordEquip: record)
                    }
                }
            }.background(Color.blue.opacity(1/8))
        )
    }
    
    private func cellsPersonsView(personnelsRecords: [PersonnelLossesModel]) -> AnyView {
        return AnyView(
            Group {
                HStack{
                    TextField("Search by date or day...", text: $searchText)
                        .padding(5)
                        .background(Color.gray.opacity(1/5))
                        .cornerRadius(8)
                        .padding(.leading)
                    
                    Button(action: {
                        isSorted.toggle()
                    }, label: {
                        HStack {
                            Text("Sort by Date")
                            Image(systemName: isSorted ? "arrow.up" : "arrow.down")
                        }
                    })
                    .padding(5)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.trailing)
                }.padding(5)
                List {
                    ForEach(filteredPersonnelsRecords()) { record in
                        OnePersonCellView(oneRecordPerson: record)
                    }
                }
            }.background(Color.red.opacity(1/8))
        )
    }
    
    private func cellsOryxView(oryxRecords: [OryxLossesModel]) -> AnyView {
        return AnyView(
            Group {
                HStack{
                    TextField("Search by model...", text: $searchText)
                        .padding(5)
                        .background(Color.gray.opacity(1/5))
                        .cornerRadius(8)
                        .padding(.leading)

                    Button(action: {
                        isSorted.toggle()
                    }, label: {
                        HStack {
                            Text("Sort by Loss")
                            Image(systemName: isSorted ? "arrow.up" : "arrow.down")
                        }
                    })
                    .padding(5)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.trailing)
                }.padding(5)
                List {
                    ForEach(filteredOryxRecords()) { record in
                        OneOryxCellView(oneRecordOryx: record)
                    }
                }
            }.background(Color.orange.opacity(1/8))
        )
    }
    
    private func loadRecords() {
        UrlLoadService.shared.fetchEquipJsonFromUrl (urlAddress: ConstURLs.urlLossesEquipment) { fetchedRecords in
                if let fetchedRecords = fetchedRecords {
                    DispatchQueue.main.async {
                        self.equipmentRecords = fetchedRecords.sorted { $0.date > $1.date }
                    }
                }
            }
        UrlLoadService.shared.fetchPersonsJsonFromUrl (urlAddress: ConstURLs.urlLossesPersonnel) { fetchedRecords in
                if let fetchedRecords = fetchedRecords {
                    DispatchQueue.main.async {
                        self.personnelsRecords = fetchedRecords.sorted { $0.date > $1.date }
                    }
                }
            }
        UrlLoadService.shared.fetchOryxJsonFromUrl (urlAddress: ConstURLs.urlLossesEqOryx) { fetchedRecords in
                if let fetchedRecords = fetchedRecords {
                    DispatchQueue.main.async {
                        self.oryxRecords = fetchedRecords.sorted { $0.lossesTotal ?? 0 > $1.lossesTotal ?? 0 }
                    }
                }
            }
        }
    
    func filteredEquipmentRecords() -> [EquipmentLossesModel] {
        let sortedRecords = isSorted
            ? equipmentRecords.sorted(by: { $0.day > $1.day })
            : equipmentRecords.sorted(by: { $0.day < $1.day })
        return searchText == "" ? sortedRecords : sortedRecords.filter {
            $0.date.contains(searchText) || "\($0.day)".contains(searchText)
        }
    }

    func filteredPersonnelsRecords() -> [PersonnelLossesModel] {
        let sortedRecords = isSorted
            ? personnelsRecords.sorted(by: { $0.day > $1.day })
            : personnelsRecords.sorted(by: { $0.day < $1.day })
        return searchText == "" ? sortedRecords : sortedRecords.filter {
            $0.date.contains(searchText) || "\($0.day)".contains(searchText)
        }
    }

    func filteredOryxRecords() -> [OryxLossesModel] {
        let sortedRecords = isSorted
            ? oryxRecords.sorted(by: { $0.lossesTotal ?? 0 > $1.lossesTotal ?? 0 })
            : oryxRecords.sorted(by: { $0.lossesTotal ?? 0 < $1.lossesTotal ?? 0 })
        return searchText == "" ? sortedRecords : sortedRecords.filter {
            $0.model.contains(searchText)
        }
    }
}

struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView()
            .environment(\.managedObjectContext,
                          PersistenceController.preview.container.viewContext)
    }
}
