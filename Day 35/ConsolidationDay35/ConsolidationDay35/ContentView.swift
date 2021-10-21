//
//  ContentView.swift
//  ConsolidationDay35
//
//  Created by Luke Lazzaro on 21/10/21.
//

import SwiftUI

enum GameMode {
    case settings
    case game
    case gameOver
}

enum TableMode {
    case oneToThree
    case fourToSix
    case sevenToNine
    case tenToTwelve
}

enum QuestionSetting {
    case five
    case ten
    case twenty
    case all
}

struct ContentView: View {
    @State private var currentScreen = GameMode.settings
    
    @State private var currentTable = TableMode.oneToThree
    @State private var questionSetting = QuestionSetting.five
    
    @State private var questions = [(left: Int, right: Int)]()
    
    @State private var currentQuestion = 0 {
        didSet {
            print("Current question: \(currentQuestion)")
        }
    }
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var correctAnswer: Int {
        questions[currentQuestion].left * questions[currentQuestion].right
    }
    
    @State private var answer = ""
    @State private var score = 0

    var body: some View {
        if currentScreen == .settings {
            Form {
                Section(header: Text("Which tables do you want to practice?")) {
                    Picker("Table mode", selection: $currentTable) {
                        Text("1 to 3").tag(TableMode.oneToThree)
                        Text("4 to 6").tag(TableMode.fourToSix)
                        Text("7 to 9").tag(TableMode.sevenToNine)
                        Text("10 to 12").tag(TableMode.tenToTwelve)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("How many questions?")) {
                    Picker("Question setting", selection: $questionSetting) {
                        Text("5").tag(QuestionSetting.five)
                        Text("10").tag(QuestionSetting.ten)
                        Text("20").tag(QuestionSetting.twenty)
                        Text("All").tag(QuestionSetting.all)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Button("Play") {
                        self.currentScreen = .game
                    }
                }
            }
        } else if currentScreen == .game {
            VStack {
                Text("Question \(currentQuestion + 1)")
                    .padding(.vertical, 40)
            
                Text("What is...")
                    .font(.headline)
                    .padding()
                
                if questions.count > 0 {
                    Text("\(questions[currentQuestion].left) x \(questions[currentQuestion].right)?")
                        .font(.largeTitle)
                } else {
                    Text("Loading question...")
                        .font(.largeTitle)
                }
                    
                TextField("Answer", text: $answer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding(.horizontal, 80)
                    .padding(.vertical)
                
                Button("Submit", action: checkAnswer)
            }
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                        nextQuestion()
                    }
                )
            }
            .onAppear(perform: resetGameVars)
        } else {
            VStack(spacing: 20) {
                Spacer()
            
                Text("Game Over!")
                    .font(.largeTitle)
                
                Text("You got \(score) answers correct.")
                
                Spacer()
                
                Button("Play Again") {
                    currentScreen = .game
                    resetGameVars()
                }
                
                Button("Back to Settings") {
                    currentScreen = .settings
                    resetGameVars()
                }
                
                Spacer()
            }
        }
    }
    
    func resetGameVars() {
        currentQuestion = 0
        questions.removeAll()
        generateQuestions()
        score = 0
    }
    
    func generateQuestions() {
        switch questionSetting {
        case .five:
            for _ in 1...5 {
                let leftNum = Int.random(in: 1...12)
                let rightNum = generateRightNumber()
                questions.append((left: leftNum, right: rightNum))
            }
        case .ten:
            for _ in 1...10 {
                let leftNum = Int.random(in: 1...12)
                let rightNum = generateRightNumber()
                questions.append((left: leftNum, right: rightNum))
            }
        case .twenty:
            for _ in 1...20 {
                let leftNum = Int.random(in: 1...12)
                let rightNum = generateRightNumber()
                questions.append((left: leftNum, right: rightNum))
            }
        case .all:
            for leftNum in 1...12 {
                for rightNum in getRightNumberRange() {
                    questions.append((left: leftNum, right: rightNum))
                }
            }
        }
        questions.shuffle()
    }
    
    func generateRightNumber() -> Int {
        switch currentTable {
        case .oneToThree:
            return Int.random(in: 1...3)
        case .fourToSix:
            return Int.random(in: 4...6)
        case .sevenToNine:
            return Int.random(in: 7...9)
        case .tenToTwelve:
            return Int.random(in: 10...12)
        }
    }
    
    func getRightNumberRange() -> ClosedRange<Int> {
        switch currentTable {
        case .oneToThree:
            return 1...3
        case .fourToSix:
            return 4...6
        case .sevenToNine:
            return 7...9
        case .tenToTwelve:
            return 10...12
        }
    }
    
    func checkAnswer() {
        let numAnswer = Int(answer) ?? 0
        
        if numAnswer == correctAnswer {
            alertTitle = "Correct!"
            alertMessage = "\(questions[currentQuestion].left) x \(questions[currentQuestion].right) is \(correctAnswer)."
            score += 1
        } else {
            alertTitle = "Wrong!"
            alertMessage = "\(questions[currentQuestion].left) x \(questions[currentQuestion].right) is \(correctAnswer)."
        }
        
        showingAlert = true
    }
    
    func nextQuestion() {
        checkIfGameOver()
        currentQuestion += 1
        answer = ""
    }
    
    func checkIfGameOver() {
        if currentQuestion + 1 >= questions.count {
            currentScreen = .gameOver
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
