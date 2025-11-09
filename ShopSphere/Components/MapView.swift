//
//  MapkitUIView.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 18/02/2024.
import SwiftUI
import MapKit

struct MapView: View {
    @State var mapRegion:MapCameraPosition = .region(.myRegion)
    @StateObject var locationManager: LocationManager = .init()
    @State var showMap:Bool = false
    var body: some View {
        VStack{
            if showMap{
                NavigationStack {
                    ZStack {
                        ZStack {
                            
                            Map(position: $mapRegion){
                                Marker("Position",systemImage: "mappin",coordinate: CLLocationCoordinate2D(latitude: locationManager.userLocation.latitude, longitude: locationManager.userLocation.longitude))
                                
                            }
                    
                        }.onAppear(perform: {
                            mapRegion = .region(MKCoordinateRegion(center: locationManager.userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000))
                    })
                        VStack {
                            HStack {
                                Text("My")
                                    .font(.title2.italic()).fontWeight(.bold).foregroundColor(Color.black)
                                +
                                Text("Location")
                                    .font(.title2.italic()).fontWeight(.bold).foregroundColor(Color("Prime"))
                                
                                Image("logo").resizable().frame(width: 30, height: 30)
                            }
                            .padding(.horizontal)
                            
                          
                            Text("Location name: \(locationManager.locationName)").padding(.horizontal).frame(width: .infinity, height: 50).background(.second).foregroundColor(.prime).cornerRadius(20)
                                    .onAppear {
                                        locationManager.fetchLocationName(at: locationManager.userLocation)
                                    }
                         
                            
                            Spacer()
                            NavigationLink(
                                              destination: AddLocation().navigationBarBackButtonHidden(true),
                                           
                                              label: {
                                                  HStack {
                                                      HStack {
                                                          Text("Confirm").frame(width: 200, height: 50)
                                                              .background(Color.prime)
                                                              .foregroundColor(Color("Second"))
                                                              .cornerRadius(20)
                                                              .padding(.top, 15)
                                                      }
                                               
                                                  }
                                              }
                            )
                         
                        }
                    }.environmentObject(locationManager)
                } 
                
            }else{
                VStack{
                    HStack{
                        Text("Shop")
                            .font(.title2.italic()).fontWeight(.bold).foregroundColor(Color.black)
                        +
                        Text("Sphere")
                            .font(.title2.italic()).fontWeight(.bold).foregroundColor(Color("Prime"))
                        
                      
                        
                        
                        Image("logo").resizable().frame(width: 30,height: 30)
                        
                        
                    }.padding(.horizontal)
                  Spacer()
                    ProgressView().progressViewStyle(.circular)
                    Text("Fetching yor location. . .")
                    Spacer()
                }
            }
        }.onChange(of:locationManager.isLocationAutherized ){
            oldValue, newValue in
            if newValue{
                showMap = true
            }
        }
    }
}

#Preview {
    MapView()
}
