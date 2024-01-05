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
                SplashScreenView(viewModel: SplashScreenViewModel(
                    router: router,
                    serviceLocator: Container.shared.serviceLocator.resolve())
                )
                .navigationDestination(for: Router.Destination.self) { destination in
                    switch destination {
                    case .login:
                        LoginView(
                            viewModel: LoginViewModel(
                                authenticationService: Container.shared.authenticationServices.resolve(),
                                router: router, 
                                serviceLocator: Container.shared.serviceLocator.resolve()
                            )
                        )
                        .navigationBarBackButtonHidden(true)
                    case .registration:
                        RegistrationView(
                            viewModel: RegistrationViewModel(
                                authenticationService: Container.shared.authenticationServices.resolve(),
                                router: router,
                                serviceLocator: Container.shared.serviceLocator.resolve()
                            )
                        )
                    case .tabBar:
                        MainTabBarView()
                            .navigationBarBackButtonHidden(true)
                    case .userSettings:
                        UserProfileView(
                            viewModel: UserProfileViewModel(
                                userServices: Container.shared.userServices.resolve(),
                                router: router,
                                serviceLocator: Container.shared.serviceLocator.resolve()
                            )
                        )
                    case let .contentDetails(id, isMovie):
                        ContentDetailsView(
                            viewModel: ContentDetailsViewModel(
                                router: router,
                                contentDetailsServices: Container.shared.contentDetailsServices.resolve(),
                                contentId: id,
                                isMovie: isMovie
                            )
                        )
                    }
                }
            }
            .environmentObject(router)
        }
    }
}
