//
//  FilteredListView.swift
//  CoreDataProject
//
//  Created by Luke Lazzaro on 13/11/21.
//

import SwiftUI
import CoreData

// When the filter gets updated in ContentView, this struct will be destroyed and remade with a new filter, since that filter is a @State variable.

// Content appears to be a second generic type, separated by a comma. It needs to conform to View to return it from the List.
struct FilteredListView<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    
    // if you don't like using fetchRequest.wrappedValue all the time, use this instead
    //var singers: FetchedResults<Singer> { fetchRequest.wrappedValue }
    
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest.wrappedValue, id: \.self) { singer in
            self.content(singer)
        }
    }
    
    // @escaping is required if you want to store a closure in a property so that it doesn't get removed from memory when the app leaves this scope. If you forget this step, Xcode will offer to fix it anyway.
    // @ViewBuilder is only required if you want to return more than one view from the closure that's passed in, because that will combine them into a TupleView.
    init(filterKey: String, filterValue: String, @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}
