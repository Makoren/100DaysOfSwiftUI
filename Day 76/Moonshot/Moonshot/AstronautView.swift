//
//  AstronautView.swift
//  Moonshot
//
//  Created by Luke Lazzaro on 27/10/21.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let attendedMissions: [Mission]

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(decorative: self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                        
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    ForEach(attendedMissions, id: \.id) { mission in
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 44, height: 44)
                            
                            Text(mission.displayName)
                        }
                        .accessibilityElement(children: .ignore)
                        .accessibilityLabel(mission.displayName)
                    }
                }
            }
        }
        .navigationTitle(astronaut.name)
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        var attendedMissions = [Mission]()
        let missions: [Mission] = Bundle.main.decode("missions.json")
        
        for mission in missions {
            for member in mission.crew {
                if member.name == astronaut.id {
                    attendedMissions.append(mission)
                }
            }
        }
        
        self.attendedMissions = attendedMissions
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
