//
//  Languages.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import Foundation

enum Language: String {
    case pt = "pt-BR"
    case en = "en-US"
    case fr = "fr-FR"

    static var current: Language {
        guard let languagePrefix = Locale.preferredLanguages.first?.prefix(2) else { return .en }
        switch languagePrefix {
        case "pt": return .pt
        case "en": return .en
        case "fr": return .fr
        default:   return .en
        }
    }
}
