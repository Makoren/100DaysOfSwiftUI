//
//  ContentView.swift
//  WordScramble
//
//  Created by Luke Lazzaro on 15/10/21.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"]

    var body: some View {
        if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
            if let fileContents = try? String(contentsOf: fileURL) {
                print(fileContents)
            }
        }
        
        let input = "a b c"
        let letters = input.components(separatedBy: " ")
        let letter = letters.randomElement()
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: trimmed.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: trimmed, range: range, startingAt: 0, wrap: false, language: "en")
        
        if misspelledRange.location == NSNotFound {
            print("Word spelled correctly!")
        }
    
        return List(people, id: \.self) {
            Text($0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
