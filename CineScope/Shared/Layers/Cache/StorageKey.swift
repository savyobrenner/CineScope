//
//  StorageKey.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Foundation

public enum StorageKey: CaseIterable {
    case user
    
    var key: String {
        switch self {
        case .user:
            return "user"
        }
    }
}
