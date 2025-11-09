//
//  NotificationView.swift
//  ShopSphere
//
//  Created by Feras Hani on 05/03/2024.
//

import SwiftUI

struct NotificationView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
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
                
                
            }.padding(.horizontal)
            
            Spacer()
            
        }
    }
}

#Preview {
    NotificationView()
}
