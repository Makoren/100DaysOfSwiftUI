//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Luke Lazzaro on 13/11/21.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    public var wrappedName: String {
        name ?? "Unknown candy"
    }

}

extension Candy : Identifiable {

}
