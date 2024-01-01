//
//  HomeEndpoint.swift
//  CineScope
//
//  Created by Savyo Brenner on 01/01/24.
//

import Moya
import SwiftUI

enum HomeEndpoint {
    case fetchPopularMovies
}

// MARK: - Endpoint Builder
extension HomeEndpoint: Endpoint {
    var requiresToken: Bool {
        return true
    }
    
    var baseURL: URL {
        URL(string: AppEnvironment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .fetchPopularMovies:
            return "movie/popular"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchPopularMovies:
            return .get
        }
    }
    
    private var parameters: [String: Any] {
        var params = [String: Any]()
        
        switch self {
        case .fetchPopularMovies:
            params["language"] = Language.current.rawValue
        }
        
        return params.compactMapValues({ $0 })
    }
    
    private var encoding: ParameterEncoding {
        switch method {
        case .post, .put:
            return JSONEncoding.default
        default:
            return URLEncoding.default
        }
    }
    
    var task: Task {
        .requestParameters(parameters: parameters, encoding: encoding)
    }
}
