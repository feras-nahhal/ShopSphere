//
//  ProductDetailView.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 20/01/2024.
//

import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product

    var body: some View {

            ScrollView(.vertical,showsIndicators: false) {
                
                ZStack {
                    Color.white
                    VStack(alignment:.leading ){
                        ZStack(alignment:.topTrailing ){
                            
                            Image(product.image)
                                .resizable().ignoresSafeArea()
                            
                                .frame(width: .infinity, height: 350)
                            
                        }
                        
                        VStack(alignment:.leading ){
                            HStack{
                                Text("\(product.name)").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/).bold()
                                
                                Spacer()
                                
                                Text("Price: ").font(.title2).fontWeight(.semibold)
                                +
                                Text("$\(product.price)").font(.title2).fontWeight(.semibold).foregroundColor(.green)
                                   
                            }.padding(.top,15).padding(.bottom,5)
                            
                            Text("Supplier: \(product.supplier)").foregroundColor(.gray)
                                Spacer()
                            
                            HStack{
                                Button("Buy Now") {
                                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                                }.frame(width: 150,height: 50).foregroundColor(.white).background(.prime).cornerRadius(20)
                                
                                Spacer()
                                Button("Add To Card") {
                                    cartManager.addToCart(product: product)
                                }.frame(width: 150,height: 50).foregroundColor(.prime).background(.second).cornerRadius(20)

                            }.padding(.top).padding(.bottom)
                            Spacer()
                            Text("Description:").font(.title3).fontWeight(.medium)
                        Text("\(product.description)")
                     
                        Spacer()
                           
                        
                        }.padding(.horizontal)
                            .background(.white).cornerRadius(20).offset(y:-30)
                    }
                    
                }
            }
            .ignoresSafeArea(edges: .top)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: productList[4]).environmentObject(CartManager())
    }
}
