//
//  EditeView.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 28/01/2024.
//

import SwiftUI

struct EditeView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    @State private var fullName = ""
    @State private var phoneNumber = ""
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
                        Image(systemName: "arrow.uturn.forward")
                        Text("Back")
                    }.foregroundColor(Color.red)
                }
                
                
            }.padding(.horizontal)
            
            
            
           
                
                
                VStack {
                    InputView(text: $fullName, title: "Edit name:", placeHolder: "New name").frame(width: .infinity, height: 100, alignment: .leading)
                  
                    Button("Edit") {
                        Task{
                            try await viewModel.updateUserName(newName: fullName)
                            
                        }}.frame(width:100 ,height: 50).background(.prime).foregroundColor(Color.white).cornerRadius(20).environmentObject(viewModel)
                }.padding(.bottom)
            
             
                VStack {
                    InputView(text: $phoneNumber, title: "Edit phoneNumber:", placeHolder: "new phone number").frame(width: .infinity, height: 100, alignment: .leading)
                  
                    Button("Edit") {
                        Task{
                            try await viewModel.updatePhoneNumber(phoneNumber: phoneNumber)
                         
                        }}.frame(width:100 ,height: 50).background(.prime).foregroundColor(Color.white).cornerRadius(20).environmentObject(viewModel)
                }.padding(.bottom)
            
            
            Spacer()
            ZStack {
                Button {Task {
                        do {
                            try await viewModel.updatePassword()
                      
                        } catch {
                            // Handle other errors (e.g., display an alert)
                            print("DEBUG: Password reset error - \(error.localizedDescription)")
                        }
                    }
                    } label: {
                        HStack{
                            Image(systemName: "lock.trianglebadge.exclamationmark")
                            Text("Reset password")
                        }.foregroundColor(Color.red).frame(width:200 ,height: 50).background(.prime).foregroundColor(Color.white).cornerRadius(20).environmentObject(viewModel)
                        
                }
            }
            
            
        }.environmentObject(viewModel).padding(.horizontal).preferredColorScheme(.light)
    }
}



struct EditePage_Previews: PreviewProvider {
    static var previews: some View {
        EditeView().environmentObject(AuthViewModel())
    }
}
