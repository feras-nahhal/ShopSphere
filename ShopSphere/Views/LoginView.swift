//
//  LoginView.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 25/01/2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel : AuthViewModel
    var body: some View {
        NavigationStack{
         
                
            VStack {
                
                Image(.logo).resizable().frame(width: 150,height: 150)
             
                VStack{
                    
                    InputView(text:$email, title: "Enter your email:", placeHolder: "eample@gmail.com")
                   
                    
                    InputView(text: $password, title: "password:", placeHolder: "**********", isTextField: false)
                 
             
                        Button("forget password?"){
                            Task{
                                try await viewModel.resetPassword(forEmail:email)
                            }
                        }.padding(.trailing,200).font(.callout).fontWeight(.light)
              
                }.padding(.top,50)
                
                Button("Sign In") {
                    Task{
                        try await  viewModel.signIn(withEmail: email, password: password)
                    }}.frame(width:200 ,height: 50).background(.prime).foregroundColor(Color.white).cornerRadius(20).disabled(!formIsValid).opacity(formIsValid ? 1.0 :0.5).padding(.top,15)
               
                Spacer()
                NavigationLink(destination: SignUpPage().navigationBarBackButtonHidden(true)) {
                    HStack{
                        Text("Don't have an account?")
                        Text("Sign Up").font(.callout).fontWeight(.bold)
                    }.foregroundColor(Color.red)
                }
    
            }
            
        }.preferredColorScheme(.light)
    }
}
extension LoginView : AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
