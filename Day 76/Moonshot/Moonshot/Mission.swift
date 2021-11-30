//
//  Mission.swift
//  Moonshot
//
//  Created by Luke Lazzaro on 26/10/21.
//

import Foundation

struct Mission: Codable, Identifiable {
    struct CrewRole: Codable, Equatable {
        let name: String
        let role: String
    }

    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
    
    var formattedCrewNames: String {
        var string = ""
        for member in crew {
            string.append(member.name.capitalized)
            if member != crew.last {
                string.append(", ")
            }
        }
        return string
    }
}
