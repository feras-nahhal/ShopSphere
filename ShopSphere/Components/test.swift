//
//  test.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 25/02/2024.
//

import SwiftUI
import Firebase

struct Test: View {
    @State var locations: [Location] = []
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
                 ForEach(locations, id: \.id) { location in
                     ZStack {
                         VStack {
                             HStack {
                                 Text("Name:")
                                 Spacer()
                                 Text(viewModel.currentUser?.fullName ?? "").font(.headline).fontWeight(.bold)
                             }.padding()
                             
                             
                             HStack {
                                 Text("apartment:")
                                 Spacer()
                                 Text("\(location.apartment)")
                             
                             }.padding()
                             
                             HStack {
                                 Text("floor:")
                                 Spacer()
                                 Text("\(location.floor)")
                        
                             }.padding()
                             HStack {
                                 Text("building:")
                                 Spacer()
                                 Text("\(location.building)")
                             }.padding()
                           
                                 HStack{
                                     Text("street:")
                                     Spacer()
                                     Text("\(location.street)")
                                    
                                 
                                 }.padding()
                             HStack{
                                 Text("city:")
                                 Spacer()
                                 Text("\(location.city)")
                             }.padding()
                             
                             HStack{
                                 Text("governorate:")
                                 Spacer()
                                 Text("\(location.governorate)")
                             }.padding()
                                   
                             HStack{
                                 Text("Number:")
                                 Spacer()
                                    
                                 Text(viewModel.currentUser?.phoneNumber ?? "").font(.headline).fontWeight(.bold)
                             } .padding()
                            
                         }.background(Color("Second")).foregroundColor(Color("Prime")).bold()
                             .cornerRadius(10).padding(.vertical, 10)
                     
                     }
                         
                    .environmentObject(viewModel)
                 }
             }
        .onAppear {
            fetchLocations()
        }
    }
    
    func fetchLocations() {
        do {
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
            let db = Firestore.firestore()
            
            db.collection("users").document(uid).collection("locations").getDocuments { querySnapshot, error in
                if let error = error {
                    print("Error getting documents: \(error)")
                } else {
                    self.locations = querySnapshot!.documents.compactMap { document in
                        let data = document.data()
                        let id = document.documentID
                        let street = data["street"] as? String ?? ""
                        let building = data["building"] as? String ?? ""
                        let floor = data["floor"] as? String ?? ""
                        let governorate = data["governorate"] as? String ?? ""
                        let apartment = data["apartment"] as? String ?? ""
                        let city = data["city"] as? String ?? ""
                        let latitude = data["latitude"] as? Double ?? 0.0
                        let longitude = data["longitude"] as? Double ?? 0.0
                        
                        return Location(id: id, street: street, building: building, floor: floor, governorate: governorate, apartment: apartment, city: city, latitude: latitude, longitude: longitude)
                    }
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test().environmentObject(AuthViewModel())
    }
}
