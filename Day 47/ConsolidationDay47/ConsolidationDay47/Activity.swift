//
//  Activity.swift
//  ConsolidationDay47
//
//  Created by Luke Lazzaro on 2/11/21.
//

import Foundation

struct Activity: Identifiable, Codable {
    var id = UUID()
    var name: String
    var description: String
    var completionCounter: Int
}

class ActivityData: ObservableObject {
    @Published var activities: [Activity] = [] {
        didSet {
            // save activities every time it changes
            let encoder = JSONEncoder()
            if let json = try? encoder.encode(activities) {
                UserDefaults.standard.set(json, forKey: "activities")
            } else {
                print("Could not save data to UserDefaults.")
            }
        }
    }
    
    init() {
        // load data from UserDefaults when the app launches
        let decoder = JSONDecoder()
        let data = UserDefaults.standard.data(forKey: "activities") ?? Data()
        if let decoded = try? decoder.decode([Activity].self, from: data) {
            activities = decoded
        } else {
            print("Could not load data from UserDefaults.")
        }
    }
}
