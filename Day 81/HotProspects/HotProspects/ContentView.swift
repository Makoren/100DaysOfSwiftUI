//
//  ContentView.swift
//  HotProspects
//
//  Created by Luke Lazzaro on 4/12/21.
//

import SwiftUI
import UserNotifications
import SamplePackage

struct ContentView: View {
    @State private var backgroundColor = Color.red
    
    let possibleNumbers = Array(1...60)
    
    var results: String {
        let selected = possibleNumbers.random(7).sorted()
        let strings = selected.map(String.init)
        return strings.joined(separator: ", ")
    }

    // package dependencies
    var body: some View {
        Text(results)
        
    // local notifications
//        VStack {
//            Button("Request permission") {
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                    if success {
//                        print("All set!")
//                    } else if let error = error {
//                        print(error.localizedDescription)
//                    }
//                }
//            }
//
//            Button("Schedule notification") {
//                let content = UNMutableNotificationContent()
//                content.title = "Feed the cat"
//                content.subtitle = "It looks hungry"
//                content.sound = UNNotificationSound.default
//
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
//                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//
//                UNUserNotificationCenter.current().add(request)
//            }
//        }
    
    // context menus
//        VStack {
//            Text("Hello world!")
//                .padding()
//                .background(backgroundColor)
//
//            Text("Change color")
//                .padding()
//                .contextMenu {
//                    Button {
//                        backgroundColor = .red
//                    } label: {
//                        Label("Red", systemImage: "checkmark.circle.fill")
//                            .foregroundColor(.red)
//                    }
//
//                    Button("Green") {
//                        backgroundColor = .green
//                    }
//
//                    Button("Blue") {
//                        backgroundColor = .blue
//                    }
//                }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
