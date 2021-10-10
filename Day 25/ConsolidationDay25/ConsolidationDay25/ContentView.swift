//
//  ContentView.swift
//  ConsolidationDay25
//
//  Created by Luke Lazzaro on 11/10/21.
//

import SwiftUI

enum MoveType: Int, CaseIterable {
    case rock
    case paper
    case scissors
}

struct ContentView: View {
    let moves = ["Rock", "Paper", "Scissors"]
    @State private var currentChoice = MoveType.allCases.randomElement()!
    @State private var shouldWin = Bool.random()
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertButtonText = ""
    
    @State private var score = 0
    @State private var gameCounter = 0
    
    @State private var showAlert = false
    
    var gameOver: Bool {
        get { return gameCounter >= 10 }
    }
    
    var correctMoveMessage: String {
        get {
            if shouldWin {
                return "What is the winning move?"
            } else {
                return "What is the losing move?"
            }
        }
    }

    var body: some View {
        VStack {
            Spacer()
        
            Text(!gameOver ? moves[currentChoice.rawValue] : "Game Over!")
                .font(.largeTitle)
                .padding()
                
            Text(!gameOver ? correctMoveMessage : "Your final score is \(score).")
                .font(.title)
                
            Spacer()
            Spacer()
            
            if !gameOver {
                HStack(spacing: 50) {
                    Button("Rock") {
                        self.checkAnswer(choice: .rock)
                    }
                    
                    Button("Paper") {
                        self.checkAnswer(choice: .paper)
                    }
                    
                    Button("Scissors") {
                        self.checkAnswer(choice: .scissors)
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text(alertButtonText)) {
                        self.nextQuestion()
                    })
                }
            } else {
                Button("Restart Game") {
                    self.restartGame()
                }
            }
            
            Spacer()
        }
    }
    
    func checkAnswer(choice: MoveType) {
        if choice == .rock {
            if currentChoice == .paper && !shouldWin {
                correctAnswer()
            } else if currentChoice == .scissors && shouldWin {
                correctAnswer()
            } else {
                wrongAnswer()
            }
        } else if choice == .paper {
            if currentChoice == .scissors && !shouldWin {
                correctAnswer()
            } else if currentChoice == .rock && shouldWin {
                correctAnswer()
            } else {
                wrongAnswer()
            }
        } else {
            if currentChoice == .rock && !shouldWin {
                correctAnswer()
            } else if currentChoice == .paper && shouldWin {
                correctAnswer()
            } else {
                wrongAnswer()
            }
        }
    }
    
    func correctAnswer() {
        alertTitle = "Correct!"
        score += 1
        alertMessage = "Your score is now \(score)."
        alertButtonText = "Continue"
        showAlert = true
    }
    
    func wrongAnswer() {
        alertTitle = "Wrong!"
        alertMessage = "No score has been added."
        alertButtonText = "Continue"
        showAlert = true
    }
    
    func nextQuestion() {
        gameCounter += 1
        
        if !gameOver {
            currentChoice = MoveType.allCases.randomElement()!
            shouldWin = Bool.random()
        }
    }
    
    func restartGame() {
        score = 0
        gameCounter = 0
        nextQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
