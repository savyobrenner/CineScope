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
    @State private var selectedTab: TabItems = .home

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.backgroundColor = UIColor.black

        let normalAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray]
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes

        let selectedAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white]
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes

        UITabBar.appearance().standardAppearance = appearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(
                viewModel: HomeViewModel(
                    homeServices: Container.shared.homeServices.resolve(),
                    router: router,
                    serviceLocator: Container.shared.serviceLocator.resolve()
                )
            )
            .tag(TabItems.home)
            .tabItem {
                tabItemContent(for: .home)
            }
            
            SearchView()
                .tag(TabItems.search)
                .tabItem {
                    tabItemContent(for: .search)
                }
            
            DownloadsView()
                .tag(TabItems.downloads)
                .tabItem {
                    tabItemContent(for: .downloads)
                }
        }
    }

    private func tabItemContent(for tab: TabItems) -> some View {
        VStack {
            Image(tab.iconName)
                .renderingMode(.template)
                .foregroundColor(selectedTab == tab ? .white : .gray)
            Text(tab.title)
                .font(.brand(.semibold, size: 12))
                .foregroundColor(selectedTab == tab ? .white : .gray)
        }
    }
}
