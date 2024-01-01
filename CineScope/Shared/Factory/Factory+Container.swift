//
//  Factory+Container.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import Factory

extension Container {
    var serviceLocator: Factory<ServiceLocatorProtocol> {
        self {
            ServiceLocator(
                network: self.networkServices.resolve(),
                cacheManager: self.cacheManager.resolve(),
                userSettings: self.userSettings.resolve()
            )
        }.singleton
    }
    
    var networkServices: Factory<NetworkProtocol> {
        self { MoyaManager() }
    }
    
    var cacheManager: Factory<CacheManagerProtocol> {
        self { CacheManager() }
    }
    
    var userSettings: Factory<UserSettingsProtocol> {
        self { UserSettings() }
    }
    
    var authenticationServices: Factory<AuthenticationProtocol> {
        self { FirebaseManager() }
    }
    
    var homeServices: Factory<HomeServicesProtocol> {
        self { HomeServices(network: self.networkServices.resolve()) }
    }
}
