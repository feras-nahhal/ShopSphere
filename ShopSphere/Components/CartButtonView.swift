//
//  CartButtonView.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 16/01/2024.
//

import SwiftUI

struct CartButtonView: View {
    var numberOfProduct: Int
 

    var body: some View {
        ZStack {
            Image(systemName: "cart")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(Color("Prime"))

            if numberOfProduct > 0 {
                Text("\(numberOfProduct)")
                    .foregroundColor(.white)
                    .font(.caption)
                    .fontWeight(.bold)
                    .frame(width: 20, height: 20)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: 10, y: -10)
            }
        }
    }
}

struct CartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CartButtonView(numberOfProduct: 1)
            
    }
}
