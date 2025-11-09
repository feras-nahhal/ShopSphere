//
//  AddLocation.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 15/02/2024.
//
import SwiftUI

struct AddLocation: View {
    @State private var governorate = ""
    @State private var city = ""
    @State private var streetName = ""
    @State private var buildingNumber = ""
    @State private var floorNumber = ""
    @State private var apartmentNumber = ""
    @State private var phoneNumber = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel : AuthViewModel
    @StateObject var locationManager: LocationManager = .init()
    @State private var isSubmitButtonPressed = false
 
    var body: some View {
        VStack {
            HStack{
                Text("Location")
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
                 
                    InputView(text:$phoneNumber, title: "Phone number", placeHolder: "Enter your phone number")
                    
                    InputView(text:$governorate, title: "Governorate", placeHolder: "Enter your Governorate")
                    
                    InputView(text:$city, title: "City", placeHolder: "Enter your email")
                    
                    InputView(text:$streetName, title: "Street Name", placeHolder: "Enter your street name")
                    
                  
                    InputView(text:$buildingNumber, title: "Building number", placeHolder: "Enter your building number")
                    
                    InputView(text:$floorNumber, title: "Floor number", placeHolder: "Enter your Floor number")
                    
                    InputView(text:$apartmentNumber, title: "Apartment number", placeHolder: "Enter your Apartment number")
          
                    Button("Submit") {
                        Task{
                            try await viewModel.addLocationForUser(street: streetName, building: buildingNumber ,floor: floorNumber ,governorate: governorate, apartment:apartmentNumber,city: city,latitude:locationManager.userLocation.latitude, longitude: locationManager.userLocation.longitude)
                            try await viewModel.updatePhoneNumber(phoneNumber: phoneNumber)
                            
                            isSubmitButtonPressed = true
                        }
                       }.frame(width:200 ,height: 50).background(.prime).foregroundColor(Color.white).disabled(!formIsValid).opacity(formIsValid ? 1.0 :0.5).cornerRadius(20).padding(.top,15)
        
                    Button{
                        isSubmitButtonPressed = true
                    } label: {
                        HStack{
                            Text("Already have an account?")
                            Text("Sign in").font(.callout).fontWeight(.bold)
                        }.foregroundColor(Color.red)
                    }
                    
                    NavigationLink(
                        destination: ContentView().navigationBarBackButtonHidden(true),
                                           isActive: $isSubmitButtonPressed,
                                           label: { EmptyView() }
                                       )
                }.padding(.top,40)
            }
        }.preferredColorScheme(.light)
    }
}
extension AddLocation : AuthenticationFormProtocol{
    var formIsValid: Bool {
        return !governorate.isEmpty
        && !city.isEmpty
        && !buildingNumber.isEmpty
        && !streetName.isEmpty
        && !floorNumber.isEmpty
        && !apartmentNumber.isEmpty
        && !phoneNumber.isEmpty
        
    }
}



struct AddLocation_Previews: PreviewProvider {
    static var previews: some View {
        AddLocation()
    }
}
