//
//  InvadersLossesApp.swift
//  InvadersLosses
//
//  Created by Andrii Hlybchenko on 27.08.2023.
//

import SwiftUI

@main
struct InvadersLossesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            GeneralView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
