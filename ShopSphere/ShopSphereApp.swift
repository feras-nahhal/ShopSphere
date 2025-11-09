//
//  ShopSphereApp.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 14/01/2024.
//

import SwiftUI
import FirebaseCore


@main
struct ShopSphereApp: App {
    @StateObject private var cartManager = CartManager()
    @StateObject var viewModel = AuthViewModel()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(cartManager).environmentObject(viewModel)
        }
    }
}
