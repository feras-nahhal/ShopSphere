//
//  myRegion.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 18/02/2024.
//

import Foundation
import MapKit

extension MKCoordinateRegion{
    static var myRegion: MKCoordinateRegion{
        return .init(center:.myLocation  ,latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
}
