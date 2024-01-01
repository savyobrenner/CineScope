//
//  SplashScreenViewModel.swift
//  CineScope
//
//  Created by Savyo Brenner on 01/01/24.
//

import Foundation

final class SplashScreenViewModel: SplashScreenViewModelProtocol {
    
    private let router: Router
    private let serviceLocator: ServiceLocatorProtocol
    
    init(router: Router, serviceLocator: ServiceLocatorProtocol) {
        self.router = router
        self.serviceLocator = serviceLocator
    }
    
    func proceedNavigation() {
        if let _ = try? serviceLocator.cacheManager.fetch(User.self, for: .user) {
            router.navigate(to: .tabBar)
        } else {
            router.navigate(to: .login)
        }
    }
}
