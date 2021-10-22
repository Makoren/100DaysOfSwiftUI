//
//  ContentView.swift
//  ConsolidationDay35
//
//  Created by Luke Lazzaro on 21/10/21.
//

import SwiftUI

enum GameMode {
    case title
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

// Ideas:
// - Animal pack from Kenney is used to display various animated animals throughout the app
// - Some sort of spiralling light coming from the game's title
// - Make the Picker look more interesting?

struct ContentView: View {
    @State private var currentScreen = GameMode.title
    
    @State private var currentTable = TableMode.oneToThree
    @State private var questionSetting = QuestionSetting.five
    
    @State private var questions = [(left: Int, right: Int)]()
    
    @State private var currentQuestion = 0
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    var correctAnswer: Int {
        questions[currentQuestion].left * questions[currentQuestion].right
    }
    
    @State private var answer = ""
    @State private var score = 0
    
    @State private var titleRotation = -8.0
    @State private var titleScale = 1.0
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }

    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
            Image("leaves")
                .resizable()
                .opacity(0.2)
                //.aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                
            
            if currentScreen == .title {
                VStack {
                    Spacer()
                    
                    VStack {
                        AnimalImage()
                        
                        Text("Animath!")
                            .font(.custom("SecularOne-Regular", size: 48))
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(titleRotation))
                            .scaleEffect(titleScale)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                                    self.titleRotation = 8.0
                                }
                                
                                withAnimation(.easeInOut(duration: 0.34).repeatForever(autoreverses: true)) {
                                    self.titleScale = 1.1
                                }
                            }
                    }
                        
                    Spacer()
                    
                    Button("Tap to Play") {
                        self.currentScreen = .settings
                    }
                    .buttonStyle(KenneyButtonStyle())
                    
                    Spacer()
                }
            } else if currentScreen == .settings {
                VStack {
                    Spacer()
                    
                    Form {
                        Section(header: Text("Which tables do you want to practice?").foregroundColor(.white)) {
                            Picker("Table mode", selection: $currentTable) {
                                Text("1 to 3").tag(TableMode.oneToThree)
                                Text("4 to 6").tag(TableMode.fourToSix)
                                Text("7 to 9").tag(TableMode.sevenToNine)
                                Text("10 to 12").tag(TableMode.tenToTwelve)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                        
                        Section(header: Text("How many questions?").foregroundColor(.white)) {
                            Picker("Question setting", selection: $questionSetting) {
                                Text("5").tag(QuestionSetting.five)
                                Text("10").tag(QuestionSetting.ten)
                                Text("20").tag(QuestionSetting.twenty)
                                Text("All").tag(QuestionSetting.all)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                        }
                    }
                    
                    Button("Play") {
                        self.currentScreen = .game
                    }
                    .buttonStyle(KenneyButtonStyle())
                    
                    Spacer()
                }
            } else if currentScreen == .game {
                VStack {
                    Text("Question \(currentQuestion + 1)")
                        .padding(.vertical, 40)
                        .foregroundColor(.white)
                        .font(.custom("SecularOne-Regular", size: 32))
                
                    Text("What is...")
                        .foregroundColor(.white)
                        .font(.custom("SecularOne-Regular", size: 18))
                    
                    if questions.count > 0 {
                        Text("\(questions[currentQuestion].left) x \(questions[currentQuestion].right)?")
                            .foregroundColor(.white)
                            .font(.custom("SecularOne-Regular", size: 48))
                    } else {
                        Text("Loading question...")
                            .foregroundColor(.white)
                            .font(.custom("SecularOne-Regular", size: 48))
                    }
                        
                    TextField("Answer", text: $answer)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding(.horizontal, 80)
                        .padding(.vertical)
                        .font(.custom("SecularOne-Regular", size: 24))
                    
                    Button("Submit", action: checkAnswer)
                        .buttonStyle(KenneyButtonStyle())
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
                    
                    AnimalImage()
                
                    Text("Game Over!")
                        .foregroundColor(.white)
                        .font(.custom("SecularOne-Regular", size: 48))
                    
                    Text("You got \(score) answers correct.")
                        .foregroundColor(.white)
                        .font(.custom("SecularOne-Regular", size: 20))
                    
                    Spacer()
                    
                    Button("Play Again") {
                        currentScreen = .game
                        resetGameVars()
                    }
                    .buttonStyle(KenneyButtonStyle())
                    
                    Button("Back to Settings") {
                        currentScreen = .settings
                        resetGameVars()
                    }
                    .buttonStyle(KenneyButtonStyle())
                    
                    Spacer()
                }
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

struct KenneyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Image(configuration.isPressed ? "red_button00" : "red_button01")
            
            configuration.label
                .foregroundColor(.white)
                .font(.custom("SecularOne-Regular", size: 18))
        }
    }
}

struct AnimalImage: View {
    static let images = ["bear", "buffalo", "chick", "chicken", "cow", "crocodile", "dog", "duck", "elephant", "frog", "giraffe", "goat", "gorilla", "hippo", "horse", "monkey", "moose", "narwhal", "owl", "panda", "parrot", "penguin", "pig", "rabbit", "rhino", "sloth", "snake", "walrus", "whale", "zebra"]
    @State private var scale = 0.5

    var body: some View {
        Image(AnimalImage.images.randomElement()!)
            .frame(width: 100, height: 100)
            .scaleEffect(0.5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
