//
//  MissionView.swift
//  Moonshot
//
//  Created by Luke Lazzaro on 27/10/21.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }

    let mission: Mission
    let crewMembers: [CrewMember]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader { geo in
                        Image(self.mission.image)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(getImageScaleAmount(geo))
                            .padding(.top)
                    }
                    .frame(maxWidth: fullView.size.width * 0.7)
                    .frame(width: fullView.size.width * 0.7, height: fullView.size.width * 0.7)
                    
                    Text("Launch Date: \(self.mission.formattedLaunchDate)")
                        .font(.headline)
                        
                    Text(self.mission.description)
                        .padding()
                        
                    Spacer(minLength: 25)
                    
                    ForEach(self.crewMembers, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(
                                        crewMember.role == "Commander" ?
                                        Capsule().stroke(Color.yellow, lineWidth: 3) :
                                        Capsule().stroke(Color.primary, lineWidth: 1)
                                    )
                                
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .navigationTitle(mission.displayName)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.crewMembers = matches
    }
    
    func getImageScaleAmount(_ geo: GeometryProxy) -> CGFloat {
        let ypos = geo.frame(in: .global).minY / 50
        if ypos > 0.2 && ypos < 1 {
            return geo.frame(in: .global).minY / 50
        } else if ypos <= 0.2 {
            return 0.2
        } else {
            return 1
        }
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")

    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
