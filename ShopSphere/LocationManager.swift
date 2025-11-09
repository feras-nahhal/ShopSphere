//
//  LocationManager.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 18/02/2024.
//

import Foundation
import MapKit


class LocationManager: NSObject,ObservableObject, CLLocationManagerDelegate {
    @Published var manager :CLLocationManager = .init()
    @Published var userLocation :CLLocationCoordinate2D = .init(latitude: 30.033333, longitude: 31.233334)
    @Published var isLocationAutherized: Bool = false
    @Published var locationName: String = ""
    
    
    override init() {
        super.init()
        
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
    
    func fetchLocationName(at coordinate: CLLocationCoordinate2D?) {
             guard let coordinate = coordinate else { return }
             let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
             CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                 guard let placemark = placemarks?.first, error == nil else {
                     self.locationName = "Location name not found"
                     return
                 }
                 self.locationName = placemark.name ?? "Unnamed Location"
             }
         }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else {return}
        print(currentLocation)
        userLocation = .init(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        isLocationAutherized = true
        fetchLocationName(at: currentLocation.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
       
    }
    
    func checkAuthorization(){
        switch manager.authorizationStatus{
        case .notDetermined:
            print("Location is not determined")
        case .denied:
            print("Location is denied")
        case .authorizedAlways,.authorizedWhenInUse:
            print("Location permision done ")
            manager.requestLocation()
        default:
            break;
        }
    }
}
