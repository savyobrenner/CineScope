//
//  UserSettings.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Foundation

protocol UserSettingsProtocol {
    var token: String { get }
}

class UserSettings: UserSettingsProtocol {
    private(set) lazy var token: String = {
        (try? ServiceLocator.shared.cacheManager.fetch(String.self, for: .token)) ?? ""
    }()
}

