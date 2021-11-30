//
//  ContentView.swift
//  Moonshot
//
//  Created by Luke Lazzaro on 25/10/21.
//

/// Accessibility Review:
/// 1. The image in MissionView is too descriptive in VoiceOver. You probably want to make it decorative.
/// 2. The astronaut buttons have a big pause between the title of the commander and their role. This can be fixed by combining the two and adding a label that says both things. The button hint is already there.
/// 3. The image in AstronautView is also too descriptive, and probably should be decorative.
/// 4. The mission label at the bottom of the AstronautView should be in a group. It would be helpful to know (for anyone, blind or otherwise) that these labels here are supposed to be for the missions this astronaut was on.
/// 5. "Moonshot" is pronounced "moon 💩" by VoiceOver...

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var areNamesDisplayed = false

    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(areNamesDisplayed ? mission.formattedCrewNames : mission.formattedLaunchDate)
                    }
                }
            }
            .navigationTitle("Moonshot")
            .toolbar {
                Button("Toggle Labels") {
                    self.areNamesDisplayed.toggle()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
