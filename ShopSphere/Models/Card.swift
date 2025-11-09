//
//  Card.swift
//  ShopSphere
//
//  Created by Feras Hani on 29/03/2024.
//

import Foundation

struct Card: Identifiable, Codable {
    var id: String
    var cardNumber: String
    var date: String
    var cardName: String
    var cvv: String
}
