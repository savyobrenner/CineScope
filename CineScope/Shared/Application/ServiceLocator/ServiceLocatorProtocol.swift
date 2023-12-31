//
//  ServiceLocatorProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

protocol ServiceLocatorProtocol {
    var network: NetworkProtocol { get }
    var cacheManager: CacheManagerProtocol { get }
    var userSettings: UserSettingsProtocol { get }
}
