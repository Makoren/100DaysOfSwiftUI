//
//  LocationPickerView.swift
//  ConsolidationDay77
//
//  Created by Luke Lazzaro on 3/12/21.
//

import SwiftUI
import MapKit

struct NewLocationView: UIViewRepresentable {
    @Binding var location: CLLocationCoordinate2D?
    let mapView = MKMapView()

    class Coordinator: NSObject, MKMapViewDelegate, CLLocationManagerDelegate {
        var parent: NewLocationView
        let manager = CLLocationManager()
        
        init(_ parent: NewLocationView) {
            self.parent = parent
            super.init()
            manager.delegate = self
            manager.requestWhenInUseAuthorization()
            manager.startUpdatingLocation()
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            parent.location = locations.first?.coordinate
            
            let annotation = MKPointAnnotation()
            annotation.title = "Found here"
            annotation.coordinate = locations.first?.coordinate ?? CLLocationCoordinate2D(latitude: 51.509865, longitude: -0.118092)
            parent.mapView.addAnnotation(annotation)
        }
    }

    func makeUIView(context: Context) -> MKMapView {
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
