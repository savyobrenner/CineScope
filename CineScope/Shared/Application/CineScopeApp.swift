//
//  CineScopeApp.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import SwiftUI

@main
struct CineScopeApp: App {
    @ObservedObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navigationPath) {
                SplashScreenView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .login:
                            LoginView()
                        case .tabBar:
                            EmptyView()
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
