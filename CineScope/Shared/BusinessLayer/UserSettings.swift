//
//  UserSettings.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Factory

protocol UserSettingsProtocol {
    var token: String { get }
}

class UserSettings: UserSettingsProtocol {
    
    private(set) lazy var token: String = {
        (try? Container.shared.serviceLocator().cacheManager.fetch(String.self, for: .token)) ?? ""
    }()
}

