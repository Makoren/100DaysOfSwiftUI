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
    var scanDate = Date()
    fileprivate(set) var isContacted = false
    
    var scanDateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, YYYY"
        return formatter.string(from: scanDate)
    }
}

class Prospects: ObservableObject {
    static let saveKey = "SavedData"
    @Published private(set) var people: [Prospect]
    
    init() {
        // manually implement the getDocumentsDirectory function below, since this is in the intializer
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        let url = documentsDirectory.appendingPathComponent("data.json")
        if let data = try? Data(contentsOf: url) {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
    
        self.people = []
    }
    
    func toggle(_ prospect: Prospect) {
        // always call send() before changing properties to make sure there are no animation bugs
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(people) {
            let url = getDocumentsDirectory().appendingPathComponent("data.json")
            
            do {
                try encoded.write(to: url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
