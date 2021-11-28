//
//  ContentView.swift
//  Accessbility
//
//  Created by Luke Lazzaro on 29/11/21.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096"
    ]
    
    let labels = [
        "Tulips",
        "Frozen tree buds",
        "Sunflowers",
        "Fireworks"
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    @State private var estimate = 25.0
    @State private var rating = 3

    var body: some View {
        // None of this is working here and I have no idea why... The other controls work fine, just not the Stepper.
        Stepper("Rate our service: \(rating)/5", value: $rating, in: 1...5)
            .accessibilityLabel(Text("Rating"))
            .accessibilityValue(Text("\(rating) out of 5"))
    
    // values
//        // What Paul suggests you use here is already the default, so I added a different value.
//        Slider(value: $estimate, in: 0...50)
//            .padding()
//            .accessibilityValue(Text("\(Int(estimate)) percent"))
    
    // combining views
//        VStack {
//            Text("Your score is")
//            Text("1000")
//                .font(.title)
//        }
//        //.accessibilityElement(children: .combine)
//        .accessibilityElement(children: .ignore)
//        .accessibilityLabel(Text("Your score is 1000"))
    
        // hiding views from VoiceOver
//        Image(decorative: "ales-krivec-15949")
//            .accessibilityHidden(true)
    
    // accessibility basics
//        Image(pictures[selectedPicture])
//            .resizable()
//            .scaledToFit()
//            .onTapGesture {
//                self.selectedPicture = Int.random(in: 0...3)
//            }
//            .accessibilityLabel(Text(labels[selectedPicture]))
//            .accessibilityAddTraits(.isButton)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
