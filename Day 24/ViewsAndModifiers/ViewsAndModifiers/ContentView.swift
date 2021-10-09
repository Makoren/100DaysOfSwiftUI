//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Luke Lazzaro on 9/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello world!")
                .blueText()
                //.modifier(Title())
                //.titleStyle()
            
            CapsuleText(text: "First")
                .foregroundColor(.yellow)
        }
    }
}

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(Color.blue)
            .clipShape(Capsule())
    }
}

struct Blue: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func blueText() -> some View {
        self.modifier(Blue())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
