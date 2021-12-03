//
//  LocationDisplayView.swift
//  ConsolidationDay77
//
//  Created by Luke Lazzaro on 3/12/21.
//

import SwiftUI
import MapKit

struct LocationDisplayView: UIViewRepresentable {
    let location: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        
        let annotation = MKPointAnnotation()
        annotation.title = "Found here"
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
        
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
}
