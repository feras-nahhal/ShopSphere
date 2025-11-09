//
//  SettingRowView.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 26/01/2024.
//

import SwiftUI

struct SettingRowView: View {
    let imageName : String
    let title : String
    let tintColor: Color
    var body: some View {
        HStack(spacing:12){
            Image(systemName: imageName).imageScale(.small).font(.title).foregroundColor(tintColor)
            
            Text(title).font(.subheadline).fontWeight(.bold).foregroundColor(Color("Prime"))
            
        }
    }
}

#Preview {
    SettingRowView(imageName: "square.and.arrow.up", title: "hello", tintColor: Color(.systemGray))
}
