//
//  CineScopeApp.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import SwiftUI
import FirebaseCore
import Factory

@main
struct CineScopeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @ObservedObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navigationPath) {
                SplashScreenView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .login:
                            LoginView()
                                .navigationBarBackButtonHidden(true)
                        case .registration:
                            RegistrationView(
                                viewModel: RegistrationViewModel(
                                    authenticationService: Container.shared.authenticationService()
                                )
                            )
                        case .tabBar:
                            MainTabBarView()
                                .navigationBarBackButtonHidden(true)
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
