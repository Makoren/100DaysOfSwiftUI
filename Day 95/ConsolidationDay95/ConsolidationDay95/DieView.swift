//
//  DieView.swift
//  ConsolidationDay95
//
//  Created by Luke Lazzaro on 20/12/21.
//

import SwiftUI

struct DieView: View {
    @State private var dieImage = Image(systemName: "die.face.3")
    @State private var currentNumber = 3
    @EnvironmentObject var dieRolls: DieRolls

    var body: some View {
        GeometryReader { fullView in
            VStack {
                Spacer()
                dieImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: fullView.size.width * 0.7)
                    .accessibilityLabel(Text("Landed on \(currentNumber)"))
                
                Spacer()
                
                Button(action: rollDie) {
                    Text("Roll Die")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical, 20)
                        .padding(.horizontal, 40)
                        .background(.primary)
                        .clipShape(Capsule())
                }
                Spacer()
            }
            .frame(width: fullView.size.width, height: fullView.size.height)
        }
    }
    
    func rollDie() {
        currentNumber = Int.random(in: 1...6)
        let dieRoll = DieRoll(number: currentNumber)
        dieImage = dieRoll.dieImage
        dieRolls.rolls.append(dieRoll)
        dieRolls.save()
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

struct DieView_Previews: PreviewProvider {
    static var previews: some View {
        DieView()
    }
}
