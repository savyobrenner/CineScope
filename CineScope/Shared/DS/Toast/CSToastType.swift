//
//  CSToastType.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

enum CSToastType {
    case success, error, info
    
    var backgroundColor: Color {
        switch self {
        case .success:
            return .Brand.success
        case .error:
            return .Brand.error
        case .info:
            return .Brand.info
        }
    }

    var textColor: Color {
        switch self {
        case .success, .error, .info:
            return .Brand.white
        }
    }
}
