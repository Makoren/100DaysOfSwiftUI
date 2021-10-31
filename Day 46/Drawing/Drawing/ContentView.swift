//
//  ContentView.swift
//  Drawing
//
//  Created by Luke Lazzaro on 29/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var arrowWidth: CGFloat = 40
    @State private var isChangedColor = false
    @State private var hueShift = 0.0

    var body: some View {
        VStack {
            ColorCyclingRectangle(amount: 0, steps: 100, value: hueShift)
            Slider(value: $hueShift)
        }
    
//        Arrow(width: arrowWidth, height: 200)
//            .fill(isChangedColor ? .red : .blue)
//            .animation(.default, value: isChangedColor)
//            .onTapGesture {
//                self.isChangedColor = true
//                withAnimation {
//                    self.arrowWidth = 80
//                }
//            }
    }
}

struct Arrow: Shape {
    var width: CGFloat
    var height: CGFloat
    
    var animatableData: CGFloat {
        get { width }
        set { self.width = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addRect(CGRect(x: rect.midX - width / 2, y: rect.midY, width: width, height: height))
        path.move(to: CGPoint(x: rect.midX, y: rect.midY - height / 2))
        path.addLine(to: CGPoint(x: rect.midX - width * 2, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX + width * 2, y: rect.midY))
        
        return path
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps = 100
    var value = 0.0

    var body: some View {
        Rectangle()
            .overlay(LinearGradient(colors: [
                Color(hue: Double(value), saturation: 1, brightness: 1),
                Color(hue: Double(value) + 0.2, saturation: 1, brightness: 1),
                Color(hue: Double(value) + 0.4, saturation: 1, brightness: 1),
                Color(hue: Double(value) + 0.6, saturation: 1, brightness: 1),
                Color(hue: Double(value) + 0.8, saturation: 1, brightness: 1),
            ], startPoint: .top, endPoint: .bottom))
        .frame(width: 200, height: 300)
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
