//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Luke Lazzaro on 23/12/21.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
    
    init() {
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // Be careful when testing this, iOS controls when UserDefaults gets saved. Return to the home screen before pressing Stop to make sure data is saved.
        let defaults = UserDefaults.standard
        let array = Array(resorts)
        defaults.set(array, forKey: saveKey)
    }
    
    func load() {
        let defaults = UserDefaults.standard
        let loadedResorts = defaults.object(forKey: saveKey) as? [String] ?? [String]()
        resorts = Set(loadedResorts)
    }
}
