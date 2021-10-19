//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Luke Lazzaro on 6/10/21.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Russia",
        "Spain",
        "UK",
        "US"
    ].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0..<3)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var score = 0
    @State private var alertMessage = ""
    
    @State private var flag1RotationAmount: CGFloat = 0
    @State private var flag1OpacityAmount = 1.0
    @State private var flag2RotationAmount: CGFloat = 0
    @State private var flag2OpacityAmount = 1.0
    @State private var flag3RotationAmount: CGFloat = 0
    @State private var flag3OpacityAmount = 1.0
    
    @State private var isFlagRed = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                Button(action: {
                    self.flagTapped(0)
                }) {
                    Image(self.countries[0])
                        .renderingMode(.original)
                        .colorMultiply(isFlagRed ? .red : .white)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        .shadow(color: .black, radius: 2)
                        .rotation3DEffect(.degrees(flag1RotationAmount), axis: (x: 0, y: 1, z: 0))
                        .opacity(flag1OpacityAmount)
                }
                
                Button(action: {
                    self.flagTapped(1)
                }) {
                    Image(self.countries[1])
                        .renderingMode(.original)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        .shadow(color: .black, radius: 2)
                        .rotation3DEffect(.degrees(flag2RotationAmount), axis: (x: 0, y: 1, z: 0))
                        .opacity(flag2OpacityAmount)
                }
                
                Button(action: {
                    self.flagTapped(2)
                }) {
                    Image(self.countries[2])
                        .renderingMode(.original)
                        .clipShape(Capsule())
                        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        .shadow(color: .black, radius: 2)
                        .rotation3DEffect(.degrees(flag3RotationAmount), axis: (x: 0, y: 1, z: 0))
                        .opacity(flag3OpacityAmount)
                }
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title2)
                
                Spacer()
            }
        }
        .alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            alertMessage = "Your score is \(score)."
            animateFlags(number)
        } else {
            scoreTitle = "Wrong"
            score -= 1
            alertMessage = "That's the flag of \(countries[number])! Your score is \(score)."
            wrongFlag(number)
        }
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
        resetFlagAnimations()
    }
    
    func animateFlags(_ number: Int) {
        withAnimation {
            if number == 0 {
                self.flag1RotationAmount = 360
                self.flag2OpacityAmount = 0.25
                self.flag3OpacityAmount = 0.25
            } else if number == 1 {
                self.flag2RotationAmount = 360
                self.flag1OpacityAmount = 0.25
                self.flag3OpacityAmount = 0.25
            } else {
                self.flag3RotationAmount = 360
                self.flag1OpacityAmount = 0.25
                self.flag2OpacityAmount = 0.25
            }
        }
    }
    
    func wrongFlag(_ number: Int) {
        isFlagRed = true
        withAnimation(.easeInOut(duration: 2)) {
            self.isFlagRed = false
        }
    }
    
    func resetFlagAnimations() {
        flag1RotationAmount = 0
        flag1OpacityAmount = 1
        flag2RotationAmount = 0
        flag2OpacityAmount = 1
        flag3RotationAmount = 0
        flag3OpacityAmount = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
