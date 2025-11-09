//
//  AdressView.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 13/02/2024.
//

import SwiftUI

struct AdressView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
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
                            Image(systemName: "arrow.uturn.forward")
                            Text("Back")
                        }.foregroundColor(Color.red)
                    }
                    
                    
                }.padding(.horizontal).padding(.top,55)
            
                ScrollView{
                    NavigationLink(
                                      destination: MapView().navigationBarBackButtonHidden(true),
                                   
                                      label: {
                                          HStack {
                                              HStack {
                                                  Text("Add Adresss").foregroundColor(Color("Second")).padding(.leading)
                                                  Image(systemName: "plus")
                                                      .padding()
                                                      .foregroundColor(Color("Second"))
                                              }
                                              .background(Color("Prime"))
                                              .cornerRadius(20)
                                          }
                                      }
                    )
                    Test().environmentObject(AuthViewModel())
                }.padding(.horizontal)
                Spacer()
            }.ignoresSafeArea(.all)
                
        }
    }
}

#Preview {
    AdressView().environmentObject(AuthViewModel())
}
