//
//  signUpPage.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 25/01/2024.
//

import SwiftUI

struct SignUpPage: View {
    @State private var fullName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        VStack {
            Image(.logo).resizable().frame(width: 130,height: 130)
         
            VStack{
                InputView(text:$fullName, title: "Full name", placeHolder: "Enter your full name")
                
                InputView(text:$email, title: "Email Address", placeHolder: "Enter your email")
                
                InputView(text:$phoneNumber, title: "Phone number", placeHolder: "Enter your phone number")
                
              
               
                ZStack(alignment:.trailing) {
                    InputView(text: $password, title: "Password:", placeHolder: "Enter Your password", isTextField: false)
                }
                
                ZStack(alignment:.trailing) {
                    InputView(text: $confirmPassword, title: "Confirm password:", placeHolder: "Confirm Your password", isTextField: false)
                    
                    HStack{
                        if !password.isEmpty && !confirmPassword.isEmpty{
                            if password == confirmPassword{
                                Image(systemName: "checkmark.circle.fill").imageScale(.large).fontWeight(.bold).foregroundColor(Color(.systemGreen))
                            }else{
                                Image(systemName: "xmark.circle.fill").imageScale(.large).fontWeight(.bold).foregroundColor(Color(.systemRed))
                            }
                        }}.padding(.horizontal,20).padding(.vertical, -40)
                    
                    
                }
             
            }.padding(.top,40)
           
            Button("SIGN UP") {
                Task{
                    try await viewModel.createUser(withEmail:email,password: password ,fullname:fullName, phoneNumber: phoneNumber)
                }}.frame(width:200 ,height: 50).background(.prime).foregroundColor(Color.white).disabled(!formIsValid).opacity(formIsValid ? 1.0 :0.5).cornerRadius(20).padding(.top,15)
           
            Spacer()
            
            Button{
                dismiss()
            } label: {
                HStack{
                    Text("Already have an account?")
                    Text("Sign in").font(.callout).fontWeight(.bold)
                }.foregroundColor(Color.red)
            }
        }.preferredColorScheme(.light)
    }
}
extension SignUpPage : AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !fullName.isEmpty
        && !email.isEmpty
        && email.contains("@")
        && !phoneNumber.isEmpty
        && !password.isEmpty
        && password.count > 5
        && confirmPassword == password
        
    }
}



struct SignUpPage_Previews: PreviewProvider {
    static var previews: some View {
       SignUpPage()
    }
}
