//
//  ProductCardView.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 15/01/2024.
//

import SwiftUI

struct ProductCardView: View {
    @EnvironmentObject var cartManager: CartManager
    @State var product: Product
    

    var body: some View {
        ZStack {
            Color("Second").cornerRadius(15)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
          
                VStack(alignment: .center) {
                    Image(product.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 175, height: 180)
                        .cornerRadius(15)
                    VStack(alignment: .leading) {
                        HStack(alignment: .center){
                                Text(product.name)
                                .font(.callout).bold()
                                    .padding(.vertical, 1)
                                    .foregroundColor(Color.black).padding(.horizontal,5)
                           
                            Spacer()
                           
                        }.padding(.horizontal,2).padding(.bottom,-3)
                        HStack{
                            Text(product.supplier)
                                .font(.caption)
                                .foregroundColor(.gray).padding(.leading)
                            Spacer()
                            
                            Text("$ \(product.price)")
                                .bold()
                                .foregroundColor(Color.green).padding(.horizontal,1)
                            Button(action: {
                                cartManager.addToCart(product: product)
                            }) {
                                Image(systemName: "cart.fill.badge.plus")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .padding(.trailing)
                                  
                                    .foregroundColor(Color("Prime"))
                            }
                            
                    
                        }
                      
                    }
             
            }
        }
        .frame(width: 185, height: 250)
        .cornerRadius(15)
    }
}

struct ProductCardView_Preview: PreviewProvider {
    static var previews: some View {
        ProductCardView(product: productList[0])
            .environmentObject(CartManager())
    }
}
