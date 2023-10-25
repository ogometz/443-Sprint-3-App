//
//  sprint3_coredataApp.swift
//  sprint3-coredata
//
//  Created by Owen Gometz on 10/25/23.
//

import SwiftUI

@main
struct sprint3_coredataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
