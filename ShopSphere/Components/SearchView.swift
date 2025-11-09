//
//  SearchView.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 15/01/2024.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var cardManager: CartManager
    @State private var search: String = ""
    @State private var searchResults: [Product] = []
    @State var isTabsLayoutViewHidden = true
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            HStack{
                Text("Shop")
                    .font(.title2.italic()).fontWeight(.bold).foregroundColor(Color.black)
                +
                Text("Sphere")
                    .font(.title2.italic()).fontWeight(.bold).foregroundColor(Color("Prime"))
               
                Image("logo").resizable().frame(width: 30,height: 30)
                Spacer()
                Button{
                    dismiss()
                } label: {
                    HStack{
                        Text("Cancel")
                    }.foregroundColor(Color.red)
                }
                
                
            }.padding(.horizontal)
            HStack {
                HStack {
                    
                    
                 
                    TextField("Search Here", text: $search)
                        .padding()
                        .background(Color("Second"))
                        .cornerRadius(20)

                  Spacer()
                        Image(systemName: "magnifyingglass")
                            .padding()
                            .foregroundColor(Color("Prime"))
                }
                    .background(Color("Second"))
                    .cornerRadius(20)
                .padding(.horizontal)
            }
            

            List(searchResults) { product in
                NavigationLink(destination: ProductDetailView(product: product).environmentObject(cardManager)) {
                    ProductRowView(product: product)
                }
            }
            .onChange(of: search) { newSearchValue in
                searchResults = performSearch(query: newSearchValue)
            }
        }
    }

    private func performSearch(query: String) -> [Product] {
        // Implement your search logic here
        let filteredResults = productList.filter { product in
            return product.name.localizedCaseInsensitiveContains(query)
        }
        return filteredResults
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
