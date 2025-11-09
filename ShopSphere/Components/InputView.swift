//
//  InputView.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 25/01/2024.
//

import SwiftUI

struct InputView: View {
    @Binding var text : String
    let title : String
    let placeHolder : String
    var isTextField = true
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title).font(.subheadline).fontWeight(.bold).foregroundColor(Color("Prime"))
            if isTextField == false {
                SecureField(placeHolder,text: $text).autocapitalization(.none).padding(.horizontal).frame(width: .infinity,height: 50).background(.second).cornerRadius(20)
            }else{
                TextField(placeHolder,text: $text).autocapitalization(.none).padding(.horizontal).frame(width: .infinity,height: 50).background(.second).cornerRadius(20)
            }
            
        }.padding(.horizontal)
    }
}

#Preview {
    InputView(text: .constant(""), title: "Enter your Email Address", placeHolder: "example@gmail.com")
}
