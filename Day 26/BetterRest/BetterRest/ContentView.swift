//
//  ContentView.swift
//  BetterRest
//
//  Created by Luke Lazzaro on 12/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date()

    var body: some View {
        dateExamples()
    
        return VStack {
            Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                Text("\(sleepAmount, specifier: "%.2f") hours")
            }
            
            Form {
                DatePicker("Please enter a date", selection: $wakeUp, in: Date()...)
                    .labelsHidden()
            }
        }
        .padding()
    }
    
    func dateExamples() {
        // date ranges
        let now = Date()
        let tomorrow = Date().addingTimeInterval(86400)
        let range = now ... tomorrow
        print(range)
        
        // creating components from a date for more flexibility
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? Date()
        print(date)
        
        // getting components from a date
        let components2 = Calendar.current.dateComponents([.hour, .minute], from: Date())
        let hour = components2.hour ?? 0
        let minute = components2.minute ?? 0
        print(hour)
        print(minute)
        
        // formatting date strings
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        let dateString = formatter.string(from: Date())
        print(dateString)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
