//
//  Friend.swift
//  ConsolidationDay60
//
//  Created by Luke Lazzaro on 15/11/21.
//

import Foundation

struct Friend: Codable, Identifiable {
    // TODO: Each ID is unique in the JSON already. You don't need to initialize UUID.
    var id = UUID()
    var name: String
}
