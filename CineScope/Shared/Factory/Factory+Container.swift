//
//  Factory+Container.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import Factory

extension Container {
    var networkService: Factory<NetworkProtocol> {
        self { MoyaManager() }
    }
    
    var authenticationService: Factory<AuthenticationProtocol> {
        self { FirebaseManager() }
    }
}
