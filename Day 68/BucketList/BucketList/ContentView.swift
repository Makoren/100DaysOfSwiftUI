//
//  ContentView.swift
//  BucketList
//
//  Created by Luke Lazzaro on 23/11/21.
//

import SwiftUI

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    // you don't need the equivalent > function, Swift is smart enough to figure that out
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ContentView: View {
    // switching view state with enums
    enum LoadingState {
        case loading, success, failed
    }

    struct LoadingView: View {
        var body: some View {
            Text("Loading...")
        }
    }

    struct SuccessView: View {
        var body: some View {
            Text("Success!")
        }
    }

    struct FailedView: View {
        var body: some View {
            Text("Failed.")
        }
    }

    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister")
    ].sorted()
    
    var loadingState = LoadingState.loading
    
    // not recommended on model data, we should be handling data behaviour in the data model itself
//    .sorted {
//        $0.lastName < $1.lastName
//    }

    var body: some View {
        Group {
            Text("Hello World!")
                .onTapGesture(perform: onTap)
                
//            if loadingState == .loading {
//                LoadingView()
//            } else if loadingState == .success {
//                SuccessView()
//            } else if loadingState == .failed {
//                FailedView()
//            }

            switch loadingState {
            case .loading: LoadingView()
            case .success: SuccessView()
            case .failed: FailedView()
            }
        }
    }
    
    func onTap() {
        let str = "Test message"
        let url = FileManager.getDocumentsDirectory().appendingPathComponent("message.txt")
        
        do {
            try str.write(to: url, atomically: true, encoding: .utf8)
            let input = try String(contentsOf: url)
            print(input)
        } catch {
            print(error.localizedDescription)
        }
    }
}

// probably want this in any project that uses the documents directory
extension FileManager {
    static func getDocumentsDirectory() -> URL {
        let paths = self.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
