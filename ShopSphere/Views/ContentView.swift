//
//  ShopSphereApp.swift
//  ShopSphere
//
//  Created by Feras Hani Nahhal on 14/01/2024.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @StateObject var cartManager = CartManager()
    @State private var selectedTab: Tab = .Home
    @State private var isTabsLayoutViewHidden = false
    @State private var isTabsLayoutViewHiddens = false
    @State private var isTabsLayoutViewHiddens3 = false
    @State private var isTabsLayoutViewHiddens4 = false
    @State private var isTabsLayoutViewHiddens5 = false
    @State private var isTabsLayoutViewHiddens6 = false
    @Namespace var namespace
    @EnvironmentObject var viewModel: AuthViewModel

    init() {
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack {
            if let user = viewModel.userSession {
                MainTabView(selectedTab: $selectedTab,
                    isTabsLayoutViewHidden: $isTabsLayoutViewHidden, isTabsLayoutViewHiddens: $isTabsLayoutViewHiddens, isTabsLayoutViewHiddens3: $isTabsLayoutViewHiddens3, isTabsLayoutViewHiddens4: $isTabsLayoutViewHiddens4,
                isTabsLayoutViewHiddens5: $isTabsLayoutViewHiddens5, isTabsLayoutViewHiddens6: $isTabsLayoutViewHiddens6,
                            namespace: namespace)
                    .environmentObject(cartManager)
                    .transition(.slide)
            } else {
                LoginView()
                    .transition(.slide)
            }
        }.environmentObject(viewModel)
    }
}

struct MainTabView: View {
    @Binding var selectedTab: Tab
    @Binding var isTabsLayoutViewHidden: Bool
    @Binding var isTabsLayoutViewHiddens: Bool
    @Binding var isTabsLayoutViewHiddens3: Bool
    @Binding var isTabsLayoutViewHiddens4: Bool
    @Binding var isTabsLayoutViewHiddens5: Bool
    @Binding var isTabsLayoutViewHiddens6: Bool
    var namespace: Namespace.ID
    @StateObject var cartManager = CartManager()
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        TabView(selection: $selectedTab) {
            HomePage(isTabsLayoutViewHidden: $isTabsLayoutViewHidden, isTabsLayoutViewHiddens: $isTabsLayoutViewHiddens)
                .environmentObject(cartManager)

           

            CardPage(product: productList[0])
                .environmentObject(cartManager)
                .tag(Tab.Cart)

            ProfilePage(isTabsLayoutViewHiddens3: $isTabsLayoutViewHiddens3, isTabsLayoutViewHiddens5: $isTabsLayoutViewHiddens5, isTabsLayoutViewHiddens4: $isTabsLayoutViewHiddens4, isTabsLayoutViewHiddens6: $isTabsLayoutViewHiddens6)
                .environmentObject(viewModel)
                .tag(Tab.Profile)
        }
        .overlay(
            HStack {
            if !isTabsLayoutViewHiddens6{
                if !isTabsLayoutViewHiddens5{
                    if !isTabsLayoutViewHiddens4{
                        if !isTabsLayoutViewHiddens3{
                            if !isTabsLayoutViewHidden {
                                if !isTabsLayoutViewHiddens{
                                    ZStack{
                                        LinearGradient(colors: [.init(white: 0.9), .white], startPoint: .top, endPoint: .bottom)
                                            .mask {
                                                RoundedRectangle(cornerRadius: 25, style: .continuous)
                                                    .stroke(lineWidth: 6)
                                            }
                                            .background(Color("Second"))
                                            .shadow(color:.gray.opacity(0.5), radius: 5, x: 0, y: 8)
                                            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                                        TabsLayoutView(selectedTab: $selectedTab,namespace: namespace)
                                            .frame(height: 70,alignment: .center)
                                            .clipped()
                                    }
                                    .frame(height: 70,alignment: .center).padding(.horizontal,10)
                                }
                            }
                        }
                    }
                }
            }
            }
            .padding(.bottom, -15)
            , alignment: .bottom
        )
        .environmentObject(AuthViewModel()) // Add AuthViewModel to the environment
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CartManager())
            .environmentObject(AuthViewModel())
           // Add AuthViewModel to the environment
    }
}


struct TabsLayoutView: View {
    @Binding var selectedTab: Tab
    var namespace: Namespace.ID
    var body: some View {
        HStack {
            Spacer()

            ForEach(Tab.allCases.sorted()) { tab in
                TabButton(tab: tab, selectedTab: $selectedTab,namespace: namespace)
                    .frame(width: 55, height: 55)
                Spacer()
            }
        }
        
        .padding(.horizontal, 10)
    }

    private var backgroundView: some View {
        LinearGradient(colors: [.init(white: 0.9), .white], startPoint: .top, endPoint: .bottom)
            .mask {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .stroke(lineWidth: 6)
            }
            .background(Color("Second"))
            .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 8)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}

struct TabButton: View {
    let tab: Tab
    @Binding var selectedTab: Tab
    var namespace: Namespace.ID
    var body: some View {
        Button {
            withAnimation(.spring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6)) {
                selectedTab = tab
            }
        } label: {
            ZStack {
                if isSelected {
                    RoundedRectangle(cornerRadius: 13, style: .continuous)
                        .fill(Color.white)
                        .overlay(content: {
                            LinearGradient(colors: [.white.opacity(0.0001), tab.color.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
                                .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                        })
                        .shadow(color: .second, radius: 10, x: -7, y: -7)
                        .shadow(color: tab.color.opacity(0.7), radius: 10, x: 8, y: 8)
                        .cornerRadius(20)
                        .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                }

                Image(systemName: tab.icon)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(isSelected ? tab.color : .prime).bold()
                    .scaleEffect(isSelected ? 1 : 0.9)
                    .animation(isSelected ? .spring(response: 0.5, dampingFraction: 0.3, blendDuration: 1) : .spring(), value: selectedTab)
            }
        }
    }

    private var isSelected: Bool {
        selectedTab == tab
    }
}


enum Tab: Int, Identifiable, CaseIterable, Comparable {
    static func < (lhs: Tab, rhs: Tab) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    case Home  = 0
    
   
    case Cart = 1
    case Profile = 2
    
    internal var id: Int { rawValue }
    
    var icon: String {
        switch self {
        case .Home :
            return "house.fill"
    
        case .Cart:
            return "cart.fill"
            
        case .Profile:
            return "person.fill"
        }
    }
    
    var title: String {
        switch self {
            
        case .Home :
            return "Home"
       
        case .Cart:
            return "Cart"
            
        case .Profile:
            return "Profile"
        }
    }
    
    var color: Color {
        switch self {
        case .Home :
            return .green
    
        case .Cart:
            return .yellow
            
        case .Profile:
            return .blue
        }
    }
}

