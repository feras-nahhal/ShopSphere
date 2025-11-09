//
//  ProfilePage.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 26/01/2024.
//

import SwiftUI

struct ProfilePage: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @Binding var  isTabsLayoutViewHiddens3 : Bool
    @Binding var  isTabsLayoutViewHiddens5 : Bool
    @Binding var  isTabsLayoutViewHiddens4 : Bool
    @Binding var  isTabsLayoutViewHiddens6 : Bool

    var body: some View {
        NavigationView {
            NavigationStack {
                List {
                    Section {
                        HStack {
                            VStack {
                                HStack {
                                    Text("Shop")
                                        .font(.title2.italic()).fontWeight(.bold).foregroundColor(Color.black)
                                    +
                                    Text("Sphere")
                                        .font(.title2.italic()).fontWeight(.bold).foregroundColor(Color("Prime"))

                                    Spacer()
                                    Image(.logo).resizable().frame(width: 30, height: 30)
                                }
                                HStack {
                                    VStack(alignment:.leading){
                                        Text(viewModel.currentUser?.fullName ?? "").font(.headline).fontWeight(.bold)
                                        Text(viewModel.currentUser?.email ?? "").font(.caption).fontWeight(.light).foregroundColor(.blue)
                                    }
                                    Spacer()

                             
                                }
                            }
                        }
                    }
                    

                    Section("My Account") {
                        NavigationLink(
                            destination: AdressView().navigationBarBackButtonHidden(true),
                                               isActive: $isTabsLayoutViewHiddens5,
                                               label: {
                                                   SettingRowView(imageName: "location", title: "Address", tintColor: Color(.systemGray))
                                               }
                                           )
                        
                        NavigationLink(
                            destination: NotificationView().navigationBarBackButtonHidden(true),
                                               isActive: $isTabsLayoutViewHiddens4,
                                               label: {
                                                   SettingRowView(imageName: "bell", title: "Notifications", tintColor: Color(.systemGray))
                                               }
                                           )
                        NavigationLink(
                            destination: CardView().navigationBarBackButtonHidden(true),
                                               isActive: $isTabsLayoutViewHiddens6,
                                               label: {
                                                   SettingRowView(imageName: "creditcard", title: "Payment", tintColor: Color(.systemGray))
                                               }
                                           )
                    
                        NavigationLink(
                                          destination: EditeView().navigationBarBackButtonHidden(true),
                                          isActive: $isTabsLayoutViewHiddens3,
                                          label: {
                                              SettingRowView(imageName: "rectangle.and.pencil.and.ellipsis", title: "Edit account", tintColor: Color(.systemGray))
                                          }
                        ).environmentObject(viewModel)
                       
                    }

                    Section("Settings") {
                        
                        Menu{
                            Button("English") {
                                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                            }
                            Button("Arabic") {
                                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                            }
                        
                        } label: {
                            SettingRowView(imageName: "globe.europe.africa", title: "Language", tintColor: Color(.systemGray))
                        }

                        Button {
                            viewModel.signOut()
                        } label: {
                            SettingRowView(imageName: "power", title: "SignOut", tintColor: Color(.red))
                        }
                    }
                }.navigationTitle("Profile")
          
            }
        }.environmentObject(viewModel).preferredColorScheme(.light)
    }
}

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage( isTabsLayoutViewHiddens3: .constant(false), isTabsLayoutViewHiddens5: .constant(false), isTabsLayoutViewHiddens4: .constant(false), isTabsLayoutViewHiddens6: .constant(false) ).environmentObject(AuthViewModel())
    }
}
