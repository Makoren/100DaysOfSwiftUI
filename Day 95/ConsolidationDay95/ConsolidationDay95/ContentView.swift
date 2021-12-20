//
//  ContentView.swift
//  ConsolidationDay95
//
//  Created by Luke Lazzaro on 20/12/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dieRolls = DieRolls()

    var body: some View {
        TabView {
            DieView()
                .tabItem {
                    Image(systemName: "die.face.3")
                    Text("Roll Die")
                }
            
            HistoryView()
                .tabItem {
                    Image(systemName: "book")
                    Text("History")
                }
        }
        .onAppear(perform: dieRolls.load)
        .environmentObject(dieRolls)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
