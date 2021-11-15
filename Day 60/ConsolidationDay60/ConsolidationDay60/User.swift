//
//  User.swift
//  ConsolidationDay60
//
//  Created by Luke Lazzaro on 15/11/21.
//

import SwiftUI

struct User: Codable, Identifiable {
    static let pfpNames = ["pfp1", "pfp2"]

    // TODO: Each ID is unique in the JSON already. You don't need to initialize UUID.
    var id = UUID()
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
    
    var formattedDate: String {
        let isoFormatter = ISO8601DateFormatter()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        
        // If you can successfully convert the ISO date, return it. Don't bother with other date formats.
        if let date = isoFormatter.date(from: registered) {
            return formatter.string(from: date)
        } else {
            return "Unknown date"
        }
    }
    
    var profilePicture: Image {
        Image(User.pfpNames.randomElement()!)
    }
}
