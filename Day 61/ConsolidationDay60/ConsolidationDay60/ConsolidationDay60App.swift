//
//  ConsolidationDay60App.swift
//  ConsolidationDay60
//
//  Created by Luke Lazzaro on 15/11/21.
//

import SwiftUI

@main
struct ConsolidationDay60App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
