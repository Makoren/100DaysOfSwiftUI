//
//  ContentView.swift
//  TimeConverter
//
//  Created by Luke Lazzaro on 5/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var inputAmountText = ""
    
    let timeStrings = ["secs", "mins", "hours"]
    let measurementTypes: [UnitDuration] = [.seconds, .minutes, .hours]
    
    @State private var selectedInputType = 0
    @State private var selectedOutputType = 0
    
    var outputAmount: Double {
        get {
            let value = Double(inputAmountText) ?? 0
            
            let measurement = Measurement(value: value, unit: measurementTypes[selectedInputType])
            
            let convertedValue = measurement.converted(to: measurementTypes[selectedOutputType])
            
            return convertedValue.value
        }
    }

    var body: some View {
        Form {
            Section(header: Text("Input")) {
                TextField("Enter an amount", text: $inputAmountText)
                    .keyboardType(.decimalPad)
                    
                Picker("Input types", selection: $selectedInputType) {
                    ForEach(0 ..< timeStrings.count) {
                        Text("\(timeStrings[$0])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            Section(header: Text("Output")) {
                Text("\(outputAmount, specifier: "%.2f")")
                
                Picker("Output types", selection: $selectedOutputType) {
                    ForEach(0 ..< timeStrings.count) {
                        Text("\(timeStrings[$0])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
