//
//  AddCardView.swift
//  ShopSphere
//
//  Created by Feras Hani on 29/03/2024.
//

import SwiftUI

struct AddCardView: View {
    @State private var cardNumber = ""
    @State private var date = ""
    @State private var cardName = ""
    @State private var cvv = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel : AuthViewModel

    var body: some View {
        VStack {
            HStack{
                Text("Card")
                    .font(.title2.italic()).fontWeight(.bold).foregroundColor(Color.black)
                +
                Text("Info")
                    .font(.title2.italic()).fontWeight(.bold).foregroundColor(Color("Prime"))
                
             
                Image("logo").resizable().frame(width: 30,height: 30)
                
                
            }.padding(.horizontal)
         
            ScrollView {
                VStack{
                    // add location name and map
                    //add selector here
                 
                    InputView(text:$cardNumber, title: "Card number", placeHolder: "Enter your card number")
                    
                    InputView(text:$date, title: "Expiration date", placeHolder: "Enter your card expiration date")
                    
                    InputView(text:$cvv, title: "CVV", placeHolder: "Enter your cvv")
                    
                    InputView(text:$cardName, title: "Card nick name", placeHolder: "Enter your card nick name")
                    
                    Button("Submit") {
                        Task{
                            try await viewModel.addCardorUser(cardNumber:cardNumber,date:date,cardName:cardName,cvv:cvv)
                            
                        }
                        dismiss()}.frame(width:200 ,height: 50).background(.prime).foregroundColor(Color.white).disabled(!formIsValid).opacity(formIsValid ? 1.0 :0.5).cornerRadius(20).padding(.top,15)
        
                    Button{
                        dismiss()
                    } label: {
                        HStack{
                            Text("Already have an account?")
                            Text("Sign in").font(.callout).fontWeight(.bold)
                        }.foregroundColor(Color.red)
                    }
                   
                    
                }.padding(.top,40)
            }
        }.preferredColorScheme(.light)
    }
}
extension AddCardView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !cardName.isEmpty
            && !cardNumber.isEmpty
            && !date.isEmpty
            && !cvv.isEmpty
    }
}



struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView()
    }
}
