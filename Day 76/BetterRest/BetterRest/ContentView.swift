//
//  ContentView.swift
//  BetterRest
//
//  Created by Luke Lazzaro on 12/10/21.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    var calculatedTime: String {
        let model = try! SleepCalculator(configuration: MLModelConfiguration())
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do {
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: sleepTime)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            showingAlert = true
            return "Error"
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("When do you want to wake up?")) {
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    }
                    
                    Section(header: Text("Desired amount of sleep")) {
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25) {
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                        // accessibilityValue does nothing, I ran into this issue earlier too. Paul will probably update that lesson when he gets around to it.
                        .accessibilityValue(Text("\(sleepAmount) hours"))
                    }
                    
                    Section {
                        Picker("Daily coffee intake", selection: $coffeeAmount) {
                            ForEach(1..<21) {
                                Text($0 == 1 ? "1 cup" : "\($0) cups")
                            }
                        }
                    }
                    
                    Text(calculatedTime)
                        .font(.largeTitle)
                }
                .navigationTitle("BetterRest")
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
