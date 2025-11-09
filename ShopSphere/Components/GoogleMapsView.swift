//
//  GoogleMapsView.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 16/02/2024.
//

import SwiftUI
import GoogleMaps

struct GoogleMapsView: UIViewRepresentable {
    @Binding var coordinates: CLLocationCoordinate2D
    @Binding var locationName: String

    func makeUIView(context: Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: coordinates.latitude, longitude: coordinates.longitude, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        return mapView
    }

    func updateUIView(_ mapView: GMSMapView, context: Context) {
        let marker = GMSMarker()
        marker.position = coordinates
        marker.title = locationName
        marker.map = mapView
    }
}

