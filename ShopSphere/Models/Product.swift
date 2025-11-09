//
//  Product.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 15/01/2024.
//

import Foundation

struct Product : Identifiable {
    var id = UUID()
    var name : String
    var image : String
    var description : String
    var supplier : String
    var price : Int
}

var productList = [
    Product(name: "Couch jdbf dbhbk",
            image: "PHOTO5",
            description: "Remember, the specific details will vary depending on the type of product you are referring to. If you have a particular product in mind, please provide more details so I can create a more accurate product description for you ",
            supplier: "IKAI",
            price: 098),
    Product(name: "RedCouch",
            image: "PHOTO5",
            description: "Remember, the specific details will vary depending on the type of product you are referring to. If you have a particular product in mind, please provide more details so I can create a more accurate product description for you ",
            supplier: "HSCD",
            price: 898),
    Product(name: "BlueCouch",
            image: "PHOTO5",
            description: "Remember, the specific details will vary depending on the type of product you are referring to. If you have a particular product in mind, please provide more details so I can create a more accurate product description for you ",
            supplier: "HVFF",
            price: 5656),
    Product(name: "dvCouch",
            image: "PHOTO5",
            description: "Remember, the specific details will vary depending on the type of product you are referring to. If you have a particular product in mind, please provide more details so I can create a more accurate product description for you ",
            supplier: "BB",
            price: 928),
    Product(name: "vCoggg",
            image: "PHOTO5",
            description: "Remember, the specific details will vary depending on the type of product you are referring to. If you have a particular product in mind, please provide more details so I can create a more accurate product description for you ",
            supplier: "HUSMKK",
            price: 938),
    Product(name: "Chair",
            image: "PHOTO5",
            description: "Remember, the specific details will vary depending on the type of product you are referring to. If you have a particular product in mind, please provide more details so I can create a more accurate product description for you ",
            supplier: "VRYNC",
            price: 984)
]
