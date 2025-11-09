//
//  CardProductsView.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 17/01/2024.
//

import SwiftUI

struct CardProductsView: View {
    @EnvironmentObject var cartManager: CartManager
    @State var product: Product
    var body: some View {
        ZStack {
            Color("Second")
            ZStack(alignment: .bottomTrailing) {
                
                HStack(spacing: 20) {
                    Image(product.image)
                        .resizable()
                        .frame(width: 75, height: 80)
                        .cornerRadius(15)
                        .padding(.all , 5)
                    
                    VStack(alignment: .leading){
                        Text(product.name)
                            .font(.headline).fontWeight(.bold)
                            

                        Text(product.supplier)
                            .font(.caption)
                            .foregroundColor(.gray)
                          

                       
                        
                    }.padding(.horizontal,-15)
                    Spacer()
                    

                   
                }

                Button(action: {
                    cartManager.removeFromCart(product: product) { result in
                        switch result {
                        case .success:
                            // Handle success, e.g., update UI or perform other actions
                            print("Product removed successfully.")
                        case .failure(let error):
                            // Handle failure, e.g., show an error message
                            print("Error: \(error.localizedDescription)")
                            
                        }
                    }
                    
                }) {
                    Image(systemName: "trash.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.trailing)
                        .padding(.horizontal, 0)
                        .padding(.vertical, 30)
                        .foregroundColor(Color.red)
                }
                
                Text("$ \(product.price)")
                    .padding(.trailing)
                    .padding(.horizontal, 45)
                    .padding(.vertical, 30)
                    .bold()
                    .foregroundColor(Color(.green))
            }
        }
        .frame(width: .infinity, height: 90)
        .cornerRadius(15).padding(.all , 5)
    }
}

struct CardProuductView_Preview: PreviewProvider {
    static var previews: some View {
        CardProductsView(product: productList[0])
            .environmentObject(CartManager())
    }
}
