//
//  ContentView.swift
//  ConsolidationDay47
//
//  Created by Luke Lazzaro on 2/11/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model = ActivityData()
    @State private var showingSheet = false

    var body: some View {
        NavigationView {
            List {
                ForEach(model.activities) { activity in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(activity.name)
                                .font(.headline)
                            Text(activity.description)
                        }
                        
                        Spacer()
                        
                        Text("\(activity.completionCounter)")
                            .font(.headline)
                    }
                }
                .onDelete(perform: deleteActivity)
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button(action: {
                        self.showingSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
        .sheet(isPresented: $showingSheet) {
            AddActivityView(model: model)
        }
    }
    
    func deleteActivity(indexSet: IndexSet) {
        model.activities.remove(atOffsets: indexSet)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
