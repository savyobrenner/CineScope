//
//  Router.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

class Router: ObservableObject {
    public enum Destination: Codable, Hashable {
        case login
        case tabBar
    }
    
    @Published var navigationPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navigationPath.append(destination)
    }
    
    func navigateBack() {
        navigationPath.removeLast()
    }
    
    func navigateToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
}
