//
//  ContentView.swift
//  iExpense
//
//  Created by Luke Lazzaro on 22/10/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    let bronzeColor = Color(red: 194 / 255, green: 121 / 255, blue: 81 / 255)
    let silverColor = Color(red: 160 / 255, green: 161 / 255, blue: 163 / 255)
    let goldColor = Color(red: 227 / 255, green: 206 / 255, blue: 18 / 255)

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        
                        Spacer()
                        
                        Text("$\(item.amount)")
                            .foregroundColor(getColor(item))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        self.showingAddExpense = true
                    }) {
                        Image(systemName: "plus")
                    }
                    
                    EditButton()
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: self.expenses)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
    func getColor(_ item: ExpenseItem) -> Color {
        if item.amount < 10 {
            return bronzeColor
        } else if item.amount < 100 {
            return silverColor
        } else {
            return goldColor
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
