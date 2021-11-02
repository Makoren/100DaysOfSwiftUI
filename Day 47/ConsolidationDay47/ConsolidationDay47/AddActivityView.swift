//
//  AddActivityView.swift
//  ConsolidationDay47
//
//  Created by Luke Lazzaro on 2/11/21.
//

import SwiftUI

struct AddActivityView: View {
    let model: ActivityData

    @State private var nameText = ""
    @State private var descriptionText = ""
    @State private var completionCounter = 0
    
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Form {
            TextField("Name", text: $nameText)
            TextField("Description", text: $descriptionText)
            Stepper("\(completionCounter)", value: $completionCounter)
            
            Section {
                Button("Add Item") {
                    model.activities.append(Activity(name: nameText, description: descriptionText, completionCounter: completionCounter))
                    presentationMode.wrappedValue.dismiss()
                }
                
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(model: ActivityData())
    }
}
