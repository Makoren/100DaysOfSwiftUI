//
//  ContentView.swift
//  ConsolidationDay60
//
//  Created by Luke Lazzaro on 15/11/21.
//

import SwiftUI
import CoreData

/// To complete every bonus part of this milestone, you need to convert Friend data into User data. Every user has a unique ID in the fetched JSON, you could connect them somehow.
/// Core Data is not needed in this project. All you're doing here is fetching data from online and displaying it locally.

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(entity: User.entity(), sortDescriptors: []) var users: FetchedResults<User>

    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(destination: UserDetailView(user: user))  {
                    HStack {
                        Text(user.cdName)
                        Spacer()
                        Text(user.cdCompany)
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("HeadTome")
            .onAppear(perform: fetchUserData)
        }
    }
    
    func fetchUserData() {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                fatalError(error!.localizedDescription)
            }
            
            let decoder = JSONDecoder()
            decoder.userInfo[.context] = self.moc
            guard let _ = try? decoder.decode([User].self, from: data) else {
                print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            try? self.moc.save()
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
