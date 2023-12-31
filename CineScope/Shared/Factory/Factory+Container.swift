//
//  Factory+Container.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import Factory

extension Container {
    var networkService: Factory<NetworkProtocol> {
        self { MoyaManager() }
    }
    
    var cacheManager: Factory<CacheManagerProtocol> {
        self { CacheManager() }
    }
    
    var userSettings: Factory<UserSettingsProtocol> {
        self { UserSettings() }
    }
    
    var authenticationService: Factory<AuthenticationProtocol> {
        self { FirebaseManager() }
    }
    
    var serviceLocator: Factory<ServiceLocatorProtocol> {
        self {
            ServiceLocator(
                network: self.networkService.resolve(),
                cacheManager: self.cacheManager.resolve(),
                userSettings: self.userSettings.resolve()
            )
        }.singleton
    }
}
