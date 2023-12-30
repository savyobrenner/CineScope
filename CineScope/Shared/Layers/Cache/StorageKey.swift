//
//  StorageKey.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Foundation

public enum StorageKey: CaseIterable {
    case token
    
    var key: String {
        switch self {
        case .token:
            return "token"
        }
    }
}

