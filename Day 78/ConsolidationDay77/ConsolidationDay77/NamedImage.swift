//
//  NamedImage.swift
//  ConsolidationDay77
//
//  Created by Luke Lazzaro on 3/12/21.
//

import SwiftUI
import MapKit

struct NamedImage: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case name, base64Image, longitude, latitude
    }

    var id = UUID()
    var name: String
    var base64Image: String
    var location: CLLocationCoordinate2D
    
    var image: UIImage {
        if let imageData = Data(base64Encoded: base64Image) {
            return UIImage(data: imageData) ?? UIImage()
        } else {
            print("Image cannot be converted from Base 64.")
            return UIImage()
        }
    }
    
    init(name: String, base64Image: String, location: CLLocationCoordinate2D) {
        self.name = name
        self.base64Image = base64Image
        self.location = location
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        base64Image = try container.decode(String.self, forKey: .base64Image)
        
        let lat = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let lon = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(base64Image, forKey: .base64Image)
        try container.encode(location.longitude, forKey: .longitude)
        try container.encode(location.latitude, forKey: .latitude)
    }
}
