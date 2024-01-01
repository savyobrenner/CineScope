//
//  MainTabBarView.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI
import Factory

struct MainTabBarView: View {
    
    @EnvironmentObject var router: Router
    
    @State var selectedTab = 0
    
    var body: some View {
        
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                HomeView(
                    viewModel: HomeViewModel(
                        homeServices: Container.shared.homeServices.resolve(),
                        router: router,
                        serviceLocator: Container.shared.serviceLocator.resolve()
                    )
                )
                .tag(0)
                
                SearchView()
                    .tag(1)
                
                DownloadsView()
                    .tag(2)
            }
            
            ZStack {
                HStack {
                    ForEach((TabItems.allCases), id: \.self) { item in
                        Button {
                            selectedTab = item.rawValue
                        } label: {
                            customTabItem(
                                imageName: item.iconName,
                                title: item.title,
                                isActive: (selectedTab == item.rawValue)
                            )
                        }
                    }
                }
                .padding(6)
            }
            .frame(height: 70)
            .frame(maxWidth: .infinity)
            .background(.purple.opacity(0.2))
            .cornerRadius(35)
            .padding(.horizontal, 26)
        }
    }
}

private extension MainTabBarView {
    
    func customTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        HStack(spacing: 10) {
            Spacer()
            
            Image(imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .Brand.white : .gray)
                .frame(width: 20, height: 20)
            
            if isActive {
                Text(title)
                    .font(.brand(.semibold, size: 14))
                    .foregroundColor(isActive ? .Brand.white : .gray)
            }
            
            Spacer()
        }
        .frame(width: isActive ? 160 : 60, height: 40)
        .background(isActive ? Color.Brand.primary : .clear)
        .cornerRadius(30)
    }
}
