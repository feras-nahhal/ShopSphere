//
//  CardPage.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 18/01/2024.
//

import SwiftUI
import CoreLocation


struct CardPage: View {
    @EnvironmentObject var cartManager: CartManager
    @State var product: Product
  
    var body: some View {
        ZStack(alignment: .top) {
            Color.white
                .ignoresSafeArea(.all)
                .preferredColorScheme(.light)
            VStack {
               
              
                HStack(alignment:.top){
                    Text("Shop")
                        .font(.title2.italic()).fontWeight(.bold).foregroundColor(Color.black)
                    +
                    Text("Sphere")
                        .font(.title2.italic()).fontWeight(.bold).foregroundColor(Color("Prime"))
                    Spacer()
                    
                    CartButtonView(numberOfProduct: cartManager.products.count)
                }.padding(.horizontal)
                
                
                
                
                ScrollView {
                    if cartManager.cartCount>0 {
                        ForEach(cartManager.products, id: \.id) { product in
                            CardProductsView(product: product)
                        }
                        VStack {
                            HStack(){
                                Text("Your Subtotal is:").padding().font(.title2).bold()
                                Spacer()
                                Text("$\(cartManager.total).00").padding().foregroundColor(.red)
                            }
                            ZStack{
                                Color("Second")
                                Button("Check Out") {
                                    
                                }.foregroundColor(Color("Prime"))
                            }.frame(width: 150,height: 50).cornerRadius(15).padding(.bottom,60)
                        }
                    
                        
                    }else{
                        Spacer()
                        
                        Text("Your Cart Is Empty").font(.caption).fontWeight(.bold).foregroundColor(Color.red)
                        
                    }
                }
            }

        }
    }
}

struct CardPage_Previews: PreviewProvider {
    static var previews: some View {
        CardPage(product: productList[0]).environmentObject(CartManager())
    }
}

