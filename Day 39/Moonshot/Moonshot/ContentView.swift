//
//  ContentView.swift
//  Moonshot
//
//  Created by Luke Lazzaro on 25/10/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // hierarchical JSON decoding
        Button("Decode JSON") {
            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                    "street": "555, Taylor Swift Avenue",
                    "city": "Nashville"
                }
            }
            """

            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address.street)
            }
        }
    
    // navigation link
//        NavigationView {
//            List(0..<100) { row in
//                NavigationLink(destination: Text("Detail View")) {
//                    Text("Row \(row)")
//                }
//            }
//            .navigationTitle("SwiftUI")
//        }
    
    // scroll view
//        ScrollView(.vertical) {
//            VStack(spacing: 10) {
//                ForEach(0..<100) {
//                    CustomText("Item \($0)")
//                        .font(.title)
//
//                }
//            }
//            .frame(maxWidth: .infinity)
//        }
    
    // geometry reader
//        VStack {
//            GeometryReader { geo in
//                Image("unsplash")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: geo.size.width)
//            }
//        }
    }
}

struct CustomText: View {
    var text: String
    
    var body: some View {
        Text(text)
    }
    
    init(_ text: String) {
        print("Creating a new CustomText")
        self.text = text
    }
}

struct User: Codable {
    var name: String
    var address: Address
}

struct Address: Codable {
    var street: String
    var city: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
