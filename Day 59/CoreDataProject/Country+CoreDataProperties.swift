//
//  Country+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Luke Lazzaro on 13/11/21.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var shortName: String?
    @NSManaged public var candy: NSSet?
    
    public var wrappedShortName: String {
        shortName ?? "Unknown country"
    }
    
    public var wrappedFullName: String {
        fullName ?? "Unknown country"
    }
    
    // NSSet needs to be converted to a Set<Candy> to work with SwiftUI views like ForEach.
    // NSSet can contain any type, Set<Candy> cannot.
    // I attempt to downcast the NSSet to a Set<Candy>, but if it fails (aka NSSet contains something other than Candy) then create an empty array instead.
    // The set (or empty array) gets sorted and an array of Candy gets returned.
    public var candyArray: [Candy] {
        let set = candy as? Set<Candy> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for candy
extension Country {

    @objc(addCandyObject:)
    @NSManaged public func addToCandy(_ value: Candy)

    @objc(removeCandyObject:)
    @NSManaged public func removeFromCandy(_ value: Candy)

    @objc(addCandy:)
    @NSManaged public func addToCandy(_ values: NSSet)

    @objc(removeCandy:)
    @NSManaged public func removeFromCandy(_ values: NSSet)

}

extension Country : Identifiable {

}
