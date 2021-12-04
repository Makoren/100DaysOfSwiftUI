//
//  ContentView.swift
//  HotProspects
//
//  Created by Luke Lazzaro on 4/12/21.
//

import SwiftUI

enum NetworkError: Error {
    case badUrl, requestFailed, unknown
}

class DelayedUpdater: ObservableObject {
    var value = 0 {
        willSet {
            /// Alternative to setting the property as a @Published property, this gives you more fine grained control over when to send these updates.
            objectWillChange.send()
        }
    }
    
    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var updater = DelayedUpdater()

    var body: some View {
        // interpolation
        Image("example")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()
    
    // asyncAfter and objectWillChange
//        Text("Value is: \(updater.value)")
        
    // result
//        Text("Hello world!")
//            .onAppear {
//                self.fetchData(from: "https://www.apple.com") { result in
//                    switch result {
//                    case .success(let str):
//                        print(str)
//                    case .failure(let error):
//                        switch error {
//                        case .badUrl:
//                            print("Bad URL")
//                        case .requestFailed:
//                            print("Network problems")
//                        case .unknown:
//                            print("Unknown error")
//                        }
//                    }
//                }
//            }
    }
    
    /// This is a wrapper around a URLSession call which uses Result. Result is just an enum that has .success or .failure on it, and you can pass different associated values into them to provide different types of success or failure.
    func fetchData(from urlString: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        // if the URL is invalid, return immediately
        guard let url = URL(string: urlString) else {
            completion(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    // success
                    let stringData = String(decoding: data, as: UTF8.self)
                    completion(.success(stringData))
                } else if error != nil {
                    // network failure
                    completion(.failure(.requestFailed))
                } else {
                    // shouldn't be possible
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
