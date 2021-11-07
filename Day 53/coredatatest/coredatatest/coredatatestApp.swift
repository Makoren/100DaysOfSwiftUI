//
//  coredatatestApp.swift
//  coredatatest
//
//  Created by Luke Lazzaro on 8/11/21.
//

import SwiftUI

@main
struct coredatatestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
