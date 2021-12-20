//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Luke Lazzaro on 21/12/21.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna, Arya, and Toby")
        }
    }
}

struct ContentView: View {
    @State private var selectedUser: User? = nil
    @State private var layoutVertically = false
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        // switch stack type based on space available
        Group {
            if sizeClass == .compact {
                VStack(content: UserView.init)
            } else {
                HStack(content: UserView.init)
            }
        }
        
//        Group {
//            if layoutVertically {
//                VStack {
//                    UserView()
//                }
//            } else {
//                HStack {
//                    UserView()
//                }
//            }
//        }
//        .onTapGesture {
//            layoutVertically.toggle()
//        }
    
        // alert alternative
//        Text("Hello World")
//            .onTapGesture {
//                selectedUser = User()
//            }
//            .alert(item: $selectedUser) { user in
//                Alert(title: Text(user.id))
//            }
    
        // basic nav view stuff on iPad
//        NavigationView {
//            NavigationLink(destination: Text("New secondary")) {
//                Text("Hello World!")
//                    .navigationTitle("Primary")
//            }
//
//            Text("Secondary")
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
