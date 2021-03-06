//
//  Order.swift
//  CupcakeCorner
//
//  Created by Luke Lazzaro on 5/11/21.
//

import SwiftUI

class Order: ObservableObject {
    struct OrderData: Codable {
        var type = 0
        var quantity = 3
        
        var specialRequestEnabled = false {
            didSet {
                if !specialRequestEnabled {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        
        var extraFrosting = false
        var addSprinkles = false
        
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
        
        var hasValidAddress: Bool {
            if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                return false
            }
            
            return true
        }
        
        var cost: Double {
            var cost = Double(quantity) * 2
            cost += (Double(type) / 2)
            
            if extraFrosting {
                cost += Double(quantity)
            }
            
            if addSprinkles {
                cost += Double(quantity) / 2
            }
            
            return cost
        }
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var data = OrderData()
}
