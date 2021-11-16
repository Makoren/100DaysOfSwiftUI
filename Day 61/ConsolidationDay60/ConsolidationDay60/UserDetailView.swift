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
                    Text("Age: \(user.cdAge)")
                    Text("Email: \(user.cdEmail)")
                    Text("Company: \(user.cdCompany)")
                    Text("Address: \(user.cdAddress)")
                }
                
                Text(user.cdAbout)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Friends")
                        .font(.title)
                    ForEach(user.cdFriends) {
                        Text($0.cdName)
                    }
                }
                
                Text("Tags: \(user.cdTags.joined(separator: ", "))")
                    .font(.footnote)
            }
            .navigationTitle(user.cdName)
            .padding()
        }
    }
}
