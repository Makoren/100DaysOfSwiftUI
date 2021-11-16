//
//  ContentView.swift
//  Instafilter
//
//  Created by Luke Lazzaro on 17/11/21.
//

import SwiftUI

struct ContentView: View {
    @State private var blurAmount: CGFloat = 0.0
    @State private var showingActionSheet = false
    @State private var backgroundColor = Color.white
    
    var body: some View {
        Text("Hello world!")
            .frame(width: 300, height: 300)
            .background(backgroundColor)
            .onTapGesture {
                self.showingActionSheet = true
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(title: Text("Change background"), message: Text("Select a new color"), buttons: [
                    .default(Text("Red")) { self.backgroundColor = .red },
                    .default(Text("Green")) { self.backgroundColor = .green },
                    .default(Text("Blue")) { self.backgroundColor = .blue },
                    .cancel()
                ])
            }
    }
    
    // custom bindings
//    var body: some View {
//        // This is needed if you want to do more than just get and set values from a @State property. didSet doesn't work on @State properties because it will only update the UI if the wrapped State struct changes, when in reality it's the value inside that struct that is changing, not the struct itself.
//        let blur = Binding<CGFloat>(
//            get: {
//                self.blurAmount
//            },
//            set: {
//                self.blurAmount = $0
//                print("New value is \(self.blurAmount)")
//            }
//        )
//
//        return VStack {
//            Text("Hello world!")
//                .blur(radius: blurAmount)
//
//            Slider(value: blur, in: 0...20)
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
