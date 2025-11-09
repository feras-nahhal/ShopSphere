//
//  User.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 26/01/2024.
//

import Foundation

struct User : Identifiable,Codable {
    let id : String
    var fullName : String
    var email : String
    var phoneNumber: String
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from:fullName){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}
extension User {
    static var MOCK_USER = User(id:NSUUID().uuidString,fullName: "feras Hani Nahhal", email: "ferasnahhal2001@gmail.com", phoneNumber: "01004398375")
}

