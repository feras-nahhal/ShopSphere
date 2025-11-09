//
//  ProductRowView.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 20/01/2024.
//

import SwiftUI

struct ProductRowView: View {
    var product: Product
    

    var body: some View {
        HStack {
            // Display relevant information about the product
            Text(product.name)
            Spacer()
            Text("Price:  $\(product.price)")
        }
        .padding()
    }
}

struct ProductRowView_Preview: PreviewProvider {
    static var previews: some View {
        ProductRowView(product: productList[0])
           
    }
}

