//
//  User+Decodable.swift
//  ConsolidationDay60
//
//  Created by Luke Lazzaro on 16/11/21.
//

import Foundation
import CoreData
import SwiftUI

/// There's way too much to summarize here, I'll just link to the StackOverflow post that got me this solution instead: https://stackoverflow.com/a/46917019/9667910
/// The only difference is that I don't define properties here, because the Core Data entity has its codegen defined as "Category/Extension". This means Xcode will generate those properties for me, and I can still write extension code like this.
/// It's important to use NSEntityDescription.entity() like it says rather than using User.entity() and Friend.entity().

class User: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case id
        case isActive
        case name
        case age
        case company
        case email
        case address
        case about
        case registered
        case tags
        case friends
    }
    
    // id is not here since it's required for the relationship between User and Friend to work. I would rather have the code crash than have a faulty relationship.
    var cdIsActive: Bool { isActive }
    var cdName: String { name ?? "Unknown name" }
    var cdAge: Int16 { age }
    var cdCompany: String { company ?? "Unknown company" }
    var cdEmail: String { email ?? "Unknown email" }
    var cdAddress: String { address ?? "Unknown address" }
    var cdAbout: String { about ?? "Unknown description" }
    var cdRegistered: String { registered ?? "Unknown registered date" }
    var cdTags: [String] { tags ?? [] }
    var cdFriends: [Friend] { friends ?? [] }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
    
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
        self.age = try container.decode(Int16.self, forKey: .age)
        self.company = try container.decode(String.self, forKey: .company)
        self.email = try container.decode(String.self, forKey: .email)
        self.address = try container.decode(String.self, forKey: .address)
        self.about = try container.decode(String.self, forKey: .about)
        self.registered = try container.decode(String.self, forKey: .registered)
        self.tags = try container.decode([String].self, forKey: .tags)
        self.friends = try container.decode([Friend].self, forKey: .friends)
    }
    
    var formattedDate: String {
        let isoFormatter = ISO8601DateFormatter()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"

        // If you can successfully convert the ISO date, return it. Don't bother with other date formats.
        if let date = isoFormatter.date(from: cdRegistered) {
            return formatter.string(from: date)
        } else {
            return "Unknown date"
        }
    }

    var profilePicture: Image {
        Image(["pfp1", "pfp2"].randomElement()!)
    }
}

class Friend: NSManagedObject, Decodable {
    enum CodingKeys: CodingKey {
        case id, name
    }
    
    // id is not here since it's required for the relationship between User and Friend to work. I would rather have the code crash than have a faulty relationship.
    var cdName: String { name ?? "Unknown name" }
    
    required convenience public init(from decoder: Decoder) throws {
        guard let context = decoder.userInfo[CodingUserInfoKey.context] as? NSManagedObjectContext else { fatalError() }
        guard let entity = NSEntityDescription.entity(forEntityName: "Friend", in: context) else { fatalError() }
        
        self.init(entity: entity, insertInto: context)
    
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")!
}
