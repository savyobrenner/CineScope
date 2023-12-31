//
//  ServiceLocator.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Foundation

final class ServiceLocator: ServiceLocatorProtocol {
    
    var network: NetworkProtocol
    var cacheManager: CacheManagerProtocol
    var userSettings: UserSettingsProtocol
    
    init(network: NetworkProtocol,
         cacheManager: CacheManagerProtocol,
         userSettings: UserSettingsProtocol) {
        self.network = network
        self.cacheManager = cacheManager
        self.userSettings = userSettings
    }
}
