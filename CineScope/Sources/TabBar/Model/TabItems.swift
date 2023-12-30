//
//  TabItems.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import Foundation
enum TabItems: Int, CaseIterable {
    case home = 0
    case search
    case downloads
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .downloads:
            return "Download"
        }
    }
    
    var iconName: String{
        switch self {
        case .home:
            return "home_icon"
        case .search:
            return "search_icon"
        case .downloads:
            return "downloads_icon"
        }
    }
}
