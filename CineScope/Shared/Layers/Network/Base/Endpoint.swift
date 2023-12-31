//
//  Endpoint.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Factory
import Foundation
import Moya

public protocol Endpoint: TargetType {
    var requiresLogin: Bool { get }
}

extension Endpoint {
    
    private var userToken: String? {
        return Container.shared.serviceLocator().userSettings.token
    }
    
    var headers: [String: String]? {
        let jsonHeaderValue = "application/json"
        
        var headers = [
            "Content-type": jsonHeaderValue,
            "Connection": "keep-alive",
            "Accept": "application/json; charset=utf-8"
        ]
        
        if let userToken = userToken, requiresLogin {
            headers["Authorization"] = "Bearer \(userToken)"
        }
        
        return headers
    }
    
    var timeoutInterval: TimeInterval {
        return 120
    }
}

