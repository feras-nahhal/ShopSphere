//
//  ShopSphereApp.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 15/01/2024.
//

import SwiftUI
import CoreLocation
import Firebase

struct HomePage: View {
    @EnvironmentObject var cardManager: CartManager
    @State private var coordinates = CLLocationCoordinate2D(latitude: 37.333747, longitude: -122.011448)
    @State private var locationName = "Unknown"
    @Binding var  isTabsLayoutViewHidden : Bool
    @Binding var  isTabsLayoutViewHiddens : Bool
    var column = [GridItem(.adaptive(minimum: 160),spacing: 20)]

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.white
                    .ignoresSafeArea(.all)
                    .preferredColorScheme(.light)

                VStack {
                    
             
                    AppBar( locationName: $locationName, isTabsLayoutViewHidden: $isTabsLayoutViewHidden, isTabsLayoutViewHiddens: $isTabsLayoutViewHiddens)
                    
                    
                  
               
                    ScrollView{
                    ImageSliderView()
                    HStack{
                        Text("suppliers").font(.title2).fontWeight(.bold)
                        Spacer()
                        
                        Image(systemName: "globe.europe.africa").foregroundColor(Color("Prime"))
                        
                    }.padding(.horizontal)
                    
                    ScrollView(.horizontal,showsIndicators:false){
                        HStack(spacing:10){
                            ForEach(productList, id: \.id ){Product in 
                                NavigationLink{
                                    Text(Product.name)
                          
                            }label: {
                                BrandView(product: Product)
                                    
                            }

                            }
                        }.padding(.horizontal,7)
                    }
                       
                        HStack{
                            Text("Products").font(.title2).fontWeight(.bold)
                            Spacer()
                            
                            Image(systemName: "square.grid.2x2").foregroundColor(Color("Prime"))
                            
                        }.padding(.horizontal)
                        
                        LazyVGrid(columns: column,spacing: 20){
                            ForEach(productList, id: \.id ){Product in NavigationLink{
                                ProductDetailView(product: Product).environmentObject(cardManager)
                            }label: {
                                ProductCardView(product: Product)
                                    .environmentObject(cardManager)
                            }
                                
                            }
                        }.padding(.horizontal,8).padding(.bottom,65)
                
                    }
                    
                 
                }
            }

        }
       
    }


 
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage(isTabsLayoutViewHidden: .constant(false), isTabsLayoutViewHiddens: .constant(false)).environmentObject(CartManager())
    }
}

struct AppBar: View {
    @EnvironmentObject var cardManager: CartManager
    @Binding var locationName: String
    @Binding var  isTabsLayoutViewHidden : Bool
    @Binding var  isTabsLayoutViewHiddens : Bool
    @State private var isSubmitButtonPressed = false
    @State var locations: [Location] = []
    @State private var coordinates = CLLocationCoordinate2D(latitude: 37.333747, longitude: -122.011448)
   

    
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading){
               
               
                HStack{
                    Text("Shop")
                        .font(.title2.italic()).fontWeight(.bold).foregroundColor(Color.black)
                    +
                    Text("Sphere")
                        .font(.title2.italic()).fontWeight(.bold).foregroundColor(Color("Prime"))
                   
                    Image("logo").resizable().frame(width: 30,height: 30)
                    Spacer()
                    NavigationLink(
                                      destination: SearchView().navigationBarBackButtonHidden(true),
                                      isActive: $isTabsLayoutViewHidden,
                                      label: {
                                          HStack {
                                              HStack {
                                                  Text("Search").padding(.leading)
                                                  Spacer()
                                                  Image(systemName: "magnifyingglass")
                                                      .padding()
                                                      .foregroundColor(Color("Prime"))
                                              }
                                              .background(Color("Second"))
                                              .cornerRadius(25)
                                          }
                                      }
                    )
                    
                }
               
                
                NavigationLink(
                    destination: AdressView().navigationBarBackButtonHidden(true),
                                       isActive: $isTabsLayoutViewHiddens,
                                       label: {
                                           HStack{
                                               Text("Choice Location")
                                               Text(" \(locationName)").font(.caption2).fontWeight(.heavy).foregroundColor(Color("Prime"))

                                               .font(.callout).fontWeight(.bold)
                                           }.foregroundColor(Color.red)
                                       }
                                   )
              
               
            } .onAppear {
                fetchLocations()
                self.getLocationName()
             
        }
            
        }.padding(.top,-4).padding(.horizontal,10)
        .environmentObject(CartManager())
        
            
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
                    if let document = querySnapshot?.documents.first {
                        let data = document.data()
                        let latitude = data["latitude"] as? Double ?? 0.0
                        let longitude = data["longitude"] as? Double ?? 0.0
                        self.coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    }
                    
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

    
    private func getLocationName() {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)

        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                return
            }

            if let placemark = placemarks?.first {
                self.locationName = placemark.name ?? "Unknown"
            }
        }
    }
}
