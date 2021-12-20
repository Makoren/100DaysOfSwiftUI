//
//  DieRoll.swift
//  ConsolidationDay95
//
//  Created by Luke Lazzaro on 20/12/21.
//

import SwiftUI

struct DieRoll: Identifiable, Codable {
    var id = UUID()
    var number: Int
    var dateRolled = Date()
    
    var dieImage: Image {
        Image(systemName: "die.face.\(number)")
    }
    
    var formattedDateString: String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter.string(from: dateRolled)
    }
}

class DieRolls: ObservableObject {
    @Published var rolls = [DieRoll]()
    
    func save() {
        let url = getDocumentsDirectory().appendingPathComponent("rolls.json")
        if let data = try? JSONEncoder().encode(rolls) {
            do {
                try data.write(to: url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func load() {
        let url = getDocumentsDirectory().appendingPathComponent("rolls.json")
        let json = (try? String(contentsOf: url))?.data(using: .utf8) ?? Data()
        if let data = try? JSONDecoder().decode([DieRoll].self, from: json) {
            rolls = data
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
