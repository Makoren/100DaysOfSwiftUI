//
//  UserDetailView.swift
//  ConsolidationDay60
//
//  Created by Luke Lazzaro on 15/11/21.
//

import SwiftUI

struct UserDetailView: View {
    var user: User

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                // TODO: Bonus points for this if you can store it in the User struct and use it as a thumbnail in ContentView.
                user.profilePicture
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 200, height: 200)
                
                // TODO: Use green or red circle instead, Discord style
                Text(user.isActive ? "Active Now" : "Offline")
                    .foregroundColor(user.isActive ? .green : .red)
                    .font(.subheadline)
                
                VStack {
                    Text("HeadTome user since:")
                        .font(.subheadline)
                    Text(user.formattedDate)
                }
            }
        
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Age: \(user.age)")
                    Text("Email: \(user.email)")
                    Text("Company: \(user.company)")
                    Text("Address: \(user.address)")
                }
                
                Text(user.about)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Friends")
                        .font(.title)
                    ForEach(user.friends) {
                        Text($0.name)
                    }
                }
                
                Text("Tags: \(user.tags.joined(separator: ", "))")
                    .font(.footnote)
            }
            .navigationTitle(user.name)
            .padding()
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(user: User(isActive: true, name: "Donko", age: 43, company: "Donko", email: "donko@donko.com", address: "23 Donko St", about: "Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko Donko ", registered: "11/43/23", tags: ["donko"], friends: [Friend(name: "Donko")]))
    }
}
