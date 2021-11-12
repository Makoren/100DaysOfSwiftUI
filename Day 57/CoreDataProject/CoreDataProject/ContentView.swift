//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Luke Lazzaro on 12/11/21.
//

import SwiftUI
import CoreData

struct Student: Hashable {
    let name: String
}

struct ContentView: View {
    @FetchRequest(entity: Movie.entity(), sortDescriptors: []) var movies: FetchedResults<Movie>
    
    @FetchRequest(entity: Wizard.entity(), sortDescriptors: []) var wizards: FetchedResults<Wizard>
    
    @Environment(\.managedObjectContext) var moc
    
    init() {
        // lol
        PersistenceController.shared.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
    
    // Ensuring Core Data objects are unique using constraints in the data model
    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            
            Button("Add") {
                let wizard = Wizard(context: self.moc)
                wizard.name = "Harry Potter"
            }
            
            Button("Save") {
                do {
                    try self.moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

    // removing Core Data optionality and conditionally saving to moc
//    var body: some View {
//        List(movies) {
//            Text($0.wrappedTitle)
//                .font(.largeTitle)
//            Text($0.wrappedDirector)
//        }
//    }
//
//    func saveChanges() {
//        if self.moc.hasChanges {
//            try? self.moc.save()
//        }
//    }

    // hashable and \.self
//    // You can only use \.self if the type conforms to Hashable.
//    let students = [
//        Student(name: "Harry Potter"),
//        Student(name: "Hermione Granger")
//    ]
//
//    var body: some View {
//        List(students, id: \.self) { student in
//            Text(student.name)
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
