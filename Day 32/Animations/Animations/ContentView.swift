//
//  ContentView.swift
//  Animations
//
//  Created by Luke Lazzaro on 18/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0

    var body: some View {
        print(animationAmount)
    
        return Button("Tap Me!") {
            withAnimation(
                Animation.easeInOut(duration: 1)
                    .repeatCount(3, autoreverses: true)
            ) {
                self.animationAmount += 360
            }
        }
        .padding(40)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
        
        // can use animation modifier on a binding directly, instead of adding it to each view that needs the animation
//            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)
//                .padding()
        
        // pulsing effect!
//        .overlay(
//            Circle()
//                .stroke(Color.red)
//                .scaleEffect(animationAmount)
//                .opacity(Double(2 - animationAmount))
//                .animation(
//                    Animation.easeInOut(duration: 1)
//                        .repeatForever(autoreverses: false)
//                )
//        )
//        .onAppear {
//            self.animationAmount = 2
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
