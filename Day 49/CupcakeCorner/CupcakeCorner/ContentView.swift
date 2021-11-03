//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Luke Lazzaro on 4/11/21.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

// MARK: Intro to URLSession

struct ContentView: View {
    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .onAppear(perform: loadData)
    }

    func loadData() {
        // Yes this is valid use of force unwrapping! This situation can never be recovered from, since we absolutely need that URL, so we want it to crash here rather than have it fail silently.
        let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song")!
        let request = URLRequest(url: url)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    DispatchQueue.main.async {
                        self.results = decodedResponse.results
                    }
                    return
                }
            }

            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

// MARK: How manual Codable conformance works

// The @Published property wrapper does not automatically conform to Codable, because it's storing the property in a generic type. So we need to conform manually.

//class User: ObservableObject, Codable {
//
//    // This is simply an enum that stores the names of all the properties we want to save or load.
//    enum CodingKeys: CodingKey {
//        case name
//    }
//
//    @Published var name = "Paul Hudson"
//
//    // This is required for Decodable, which is one half of Codable.
//    required init(from decoder: Decoder) throws {
//        // Creates a container that holds all the properties based on what's defined in CodingKeys.
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        // Set the name property to whatever value is stored in that container at CodingKeys.name.
//        name = try container.decode(String.self, forKey: .name)
//    }
//
//    // This is required for Encodable, which is the other half of Codable. This method is basically the reverse of what I was doing in the initializer.
//    func encode(to encoder: Encoder) throws {
//        // Create a container that can be encoded using all properties defined by CodingKeys. The method knows what properties exist because that data is passed into the encoder argument.
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(name, forKey: .name)
//    }
//}

// MARK: Disabled forms

//struct ContentView: View {
//    @State private var username = ""
//    @State private var email = ""
//
//    var disableForm: Bool {
//        username.count < 5 || email.count < 5
//    }
//
//    var body: some View {
//        Form {
//            Section {
//                TextField("Username", text: $username)
//                TextField("Email", text: $email)
//            }
//
//            Section {
//                Button("Create account") {
//                    print("Creating account...")
//                }
//            }
//            .disabled(disableForm)
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
