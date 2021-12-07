//
//  Prospect.swift
//  HotProspects
//
//  Created by Luke Lazzaro on 7/12/21.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        self.people = []
    }
    
    func toggle(_ prospect: Prospect) {
        // always call send() before changing properties to make sure there are no animation bugs
        objectWillChange.send()
        prospect.isContacted.toggle()
    }
}
