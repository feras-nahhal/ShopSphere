//
//  Location.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 24/02/2024.
//

import Foundation

struct Location: Identifiable, Codable {
    var id: String 
    var street: String
    var building: String
    var floor: String
    var governorate: String
    var apartment: String
    var city: String
    var latitude: Double
    var longitude: Double
}

