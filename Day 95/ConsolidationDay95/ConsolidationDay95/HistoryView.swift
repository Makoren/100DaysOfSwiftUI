//
//  HistoryView.swift
//  ConsolidationDay95
//
//  Created by Luke Lazzaro on 20/12/21.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var dieRolls: DieRolls
    
    var numberOfOnes: Int {
        let rolls = dieRolls.rolls.filter { $0.number == 1 }
        return rolls.count
    }
    
    var numberOfTwos: Int {
        let rolls = dieRolls.rolls.filter { $0.number == 2 }
        return rolls.count
    }
    
    var numberOfThrees: Int {
        let rolls = dieRolls.rolls.filter { $0.number == 3 }
        return rolls.count
    }
    
    var numberOfFours: Int {
        let rolls = dieRolls.rolls.filter { $0.number == 4 }
        return rolls.count
    }
    
    var numberOfFives: Int {
        let rolls = dieRolls.rolls.filter { $0.number == 5 }
        return rolls.count
    }
    
    var numberOfSixes: Int {
        let rolls = dieRolls.rolls.filter { $0.number == 6 }
        return rolls.count
    }

    var body: some View {
        VStack {
            List(dieRolls.rolls.reversed()) { dieRoll in
                HStack {
                    dieRoll.dieImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 70, height: 70)
                    
                    Text(dieRoll.formattedDateString)
                        .padding()
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(Text("Rolled a \(dieRoll.number) at \(dieRoll.formattedDateString)"))
            }
            
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "die.face.1")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("\(numberOfOnes, specifier: "%02d")")
                    }
                    .padding(10)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("Landed on one \(numberOfOnes) times"))
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "die.face.2")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("\(numberOfTwos, specifier: "%02d")")
                    }
                    .padding(10)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("Landed on two \(numberOfTwos) times"))
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "die.face.3")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("\(numberOfThrees, specifier: "%02d")")
                    }
                    .padding(10)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("Landed on three \(numberOfThrees) times"))
                }
                
                HStack {
                    HStack {
                        Image(systemName: "die.face.4")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("\(numberOfFours, specifier: "%02d")")
                    }
                    .padding(10)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("Landed on four \(numberOfFours) times"))
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "die.face.5")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("\(numberOfFives, specifier: "%02d")")
                    }
                    .padding(10)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("Landed on five \(numberOfFives) times"))
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "die.face.6")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        Text("\(numberOfSixes, specifier: "%02d")")
                    }
                    .padding(10)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("Landed on six \(numberOfSixes) times"))
                }
            }
            .padding(.horizontal, 50)
            .padding(.bottom, 50)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
