//
//  ContentView.swift
//  Flashzilla
//
//  Created by Luke Lazzaro on 11/12/21.
//

import SwiftUI

struct ContentView: View {
    // creates a timer that publishes events to whatever it's connected to
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var scale: CGFloat = 1
    
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency
    
    var body: some View {
        // reduce transparency
        Text("Hello world!")
            .padding()
            .background(reduceTransparency ? Color.black : Color.black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    
    // reduce motion
//        Text("Hello world!")
//            .scaleEffect(scale)
//            .onTapGesture {
////                if reduceMotion {
////                    scale *= 1.5
////                } else {
////                    withAnimation {
////                        scale *= 1.5
////                    }
////                }
//                withOptionalAnimation {
//                    scale *= 1.5
//                }
//            }
    
    // differentiate without color
//        HStack {
//            if differentiateWithoutColor {
//                Image(systemName: "checkmark.circle")
//            }
//            Text("Success")
//        }
//        .padding()
//        .background(differentiateWithoutColor ? Color.black : Color.green)
//        .foregroundColor(.white)
//        .clipShape(Capsule())
    }

    // combine publishers
//    var body: some View {
//        VStack {
//            Text("Hello world!")
//                // onReceive is how you receive events from a publisher
//                .onReceive(timer) { time in
//                    print("The time is now \(time)")
//                }
//                .onTapGesture {
//                    // this is how you stop timers
//                    timer.upstream.connect().cancel()
//
//                    // you can also add tolerance, which will save battery life if you don't need the timing to be exact
//                }
//
//            Text("Background")
//                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
//                    print("Moving to the background!")
//                }
//                .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
//                    print("Moving back to the foreground!")
//                }
//                // there are lots of notifications like this, for example detecting when the user takes a screenshot, they can all be plugged into onReceive and responded to
//        }
//    }

    // crazy advanced Swift solution to making this accessibility code cleaner
    func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
        if UIAccessibility.isReduceMotionEnabled {
            return try body()
        } else {
            return try withAnimation(animation, body)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
