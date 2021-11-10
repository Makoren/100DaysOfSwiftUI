//
//  ContentView.swift
//  Bookworm
//
//  Created by Luke Lazzaro on 8/11/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Book.entity(), sortDescriptors: [
        NSSortDescriptor(keyPath: \Book.title, ascending: true),
        NSSortDescriptor(keyPath: \Book.author, ascending: true)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment: .leading) {
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                                .foregroundColor(book.rating > 1 ? .primary : .red)
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        EditButton()
                    
                        Button(action: {
                            self.showingAddScreen.toggle()
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    // Core Data's managed object context is shared to all children of this view, for example views shown using NavigationLink. Views shown using sheet() are not children of this view, so you need to pass the context in manually here.
                    AddBookView().environment(\.managedObjectContext, self.moc)
                }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
