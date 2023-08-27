//
//  DetailsView.swift
//  InvadersLosses
//
//  Created by Andrii Hlybchenko on 27.08.2023.
//

import SwiftUI

struct DetailsView: View {
    
    @ObservedObject var oneRecord : EquipmentLossesModel
    
    var body: some View {
        VStack {
            List {
                ForEach(oneRecord.props, id: \.0) { prop in
                    if (prop.1 != nil) {
                        HStack {
                            HStack {
                                Text("\(prop.0):")
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text("\(prop.1?.description ?? "---")")
                                Spacer()
                            }
                        }
                    }
                }
            }.navigationTitle("Info for \(formatDateToIso(dateInStr: oneRecord.date))")
        }
    }
}

struct DetailsViewP: View {
    
    @ObservedObject var oneRecord : PersonnelLossesModel
    
    var body: some View {
        VStack {
            List {
                ForEach(oneRecord.props, id: \.0) { prop in
                    HStack {
                        HStack {
                            Text("\(prop.0):")
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Text("\(prop.1?.description ?? "---")")
                            Spacer()
                        }
                    }
                }
            }.navigationTitle("Info for \(formatDateToIso(dateInStr: oneRecord.date))")
        }
    }
}
