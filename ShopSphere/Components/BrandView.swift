//
//  BrandView.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 20/01/2024.
//

import SwiftUI

struct BrandView: View {
    @State var product: Product
    var body: some View {
        ZStack {
            Color("Second")
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .leading) {
          
                    Text(product.supplier)
                        .font(.caption).fontWeight(.heavy)
                        .foregroundColor(Color("Prime"))
                        .padding(.horizontal)

                }
            }
        }
        .frame(width: 100, height: 100)
        .cornerRadius(20)
    }
    
}

struct BrandView_Preview: PreviewProvider {
    static var previews: some View {
        BrandView(product: productList[0])
            
    }
}
