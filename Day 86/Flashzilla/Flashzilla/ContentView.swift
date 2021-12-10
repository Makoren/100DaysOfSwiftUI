//
//  ContentView.swift
//  Flashzilla
//
//  Created by Luke Lazzaro on 11/12/21.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    @State private var currentAmount: CGFloat = 0
    @State private var finalAmount: CGFloat = 1
    
    @State private var currentAngle: Angle = .degrees(0)
    @State private var finalAngle: Angle = .degrees(0)
    
    @State private var offset = CGSize.zero
    @State private var isDragging = false
    
    @State private var engine: CHHapticEngine?

    var body: some View {
        Text("Hello World!")
            .onTapGesture(perform: simpleSuccess)
            .onLongPressGesture(perform: complexSuccess)
    
    // combined gestures
//        let dragGesture = DragGesture()
//            .onChanged { value in offset = value.translation }
//            .onEnded { _ in
//                withAnimation {
//                    offset = .zero
//                    isDragging = false
//                }
//            }
//
//        let pressGesture = LongPressGesture()
//            .onEnded { value in
//                withAnimation {
//                    isDragging = true
//                }
//            }
//
//        // lets you run a drag gesture after the long press succeeds
//        let combined = pressGesture.sequenced(before: dragGesture)
//
//        return Circle()
//            .fill(Color.red)
//            .frame(width: 64, height: 64)
//            .scaleEffect(isDragging ? 1.5 : 1)
//            .offset(offset)
//            .gesture(combined)
    
//        // prioritises children, unless you use .highPriorityGesture
//        // use .simultaneousGesture to do both at the same time
//        VStack {
//            Text("Hello World!")
//                .onTapGesture {
//                    print("Text tapped")
//                }
//        }
//        //.highPriorityGesture(
//        .simultaneousGesture(
//            TapGesture()
//                .onEnded { _ in
//                    print("VStack tapped")
//                }
//        )
    
//        Text("Hello, world!")
//            .rotationEffect(currentAngle + finalAngle)
//            .gesture(
//                RotationGesture()
//                    .onChanged { angle in
//                        currentAngle = angle
//                    }
//                    .onEnded { angle in
//                        finalAngle += currentAngle
//                        currentAngle = .degrees(0)
//                    }
//            )
        
//            .scaleEffect(finalAmount + currentAmount)
//            .gesture(
//                MagnificationGesture()
//                    .onChanged { amount in
//                        currentAmount = amount - 1
//                    }
//                    .onEnded { amount in
//                        finalAmount += currentAmount
//                        currentAmount = 0
//                    }
//            )
        
//            .onTapGesture(count: 2) {
//                print("Double tapped!")
//            }
//            .onLongPressGesture(minimumDuration: 1, pressing: { inProgress in
//                print("In progress: \(inProgress)!")
//            }) {
//                print("Long pressed!")
//            }
    }
    
    // these are simple functions that don't need Core Haptics to work
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func simpleFailure() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.warning)
    }
    
    // these ones require Core Haptics
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    // this is not playing haptics and i have no idea why
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
