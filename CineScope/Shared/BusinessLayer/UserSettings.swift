//
//  UserSettings.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Factory

protocol UserSettingsProtocol {
    var user: User? { get }
}

class UserSettings: UserSettingsProtocol {
    
    private(set) lazy var user: User? = {
        (try? Container.shared.serviceLocator.resolve().cacheManager.fetch(User.self, for: .user))
    }()
}

