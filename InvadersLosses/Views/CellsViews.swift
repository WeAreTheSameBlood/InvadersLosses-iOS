//
//  OneRecordView.swift
//  InvadersLosses
//
//  Created by Andrii Hlybchenko on 27.08.2023.
//

import SwiftUI

struct OneEquipCellView: View {
    
    @ObservedObject var oneRecordEquip : EquipmentLossesModel
    
    var body: some View {
        NavigationLink(destination: DetailsEquipView(oneRecord: oneRecordEquip)) {
            HStack {
                Text("Day of war: \(oneRecordEquip.day)")
                Spacer()
                Text("Date: \(formatDateToIso(dateInStr: oneRecordEquip.date))")
            }.padding(5)
        }
    }
}

struct OnePersonCellView: View {
    
    @ObservedObject var oneRecordPerson : PersonnelLossesModel
    
    var body: some View {
        NavigationLink(destination: DetailsPersonsView(oneRecord: oneRecordPerson)) {
            HStack {
                Text("Day of war: \(oneRecordPerson.day)")
                Spacer()
                Text("Date: \(formatDateToIso(dateInStr: oneRecordPerson.date))")
            }.padding(5)
        }
    }
}

struct OneOryxCellView: View {
    
    @ObservedObject var oneRecordOryx : OryxLossesModel
    
    var body: some View {
        NavigationLink(destination: DetailsOryxView(oneRecord: oneRecordOryx)) {
            HStack {
                Text("Model: \(oneRecordOryx.model)")
                Spacer()
                Text("Losses: \(oneRecordOryx.lossesTotal?.description ?? "---")")
            }.padding(5)
        }
    }
}
