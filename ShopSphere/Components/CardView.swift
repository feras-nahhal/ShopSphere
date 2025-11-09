//
//  CardView.swift
//  ShopSphere
//
//  Created by Feras Hani on 29/03/2024.
//

import SwiftUI

struct CardView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack  {
            VStack{
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
                                      destination: AddCardView().navigationBarBackButtonHidden(true),
                                   
                                      label: {
                                          HStack {
                                              HStack {
                                                  Text("Add Card").foregroundColor(Color("Second")).padding(.leading)
                                                  Image(systemName: "plus")
                                                      .padding()
                                                      .foregroundColor(Color("Second"))
                                              }
                                              .background(Color("Prime"))
                                              .cornerRadius(20)
                                          }
                                      }
                    )
                    CardInformitionView().environmentObject(AuthViewModel())
                }.padding(.horizontal)
                
                Spacer()
                
            }.ignoresSafeArea(.all)
        }
    }
}

#Preview {
    CardView().environmentObject(AuthViewModel())
}
