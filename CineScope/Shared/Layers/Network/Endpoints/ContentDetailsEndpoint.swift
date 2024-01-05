//
//  ContentDetailsEndpoint.swift
//  CineScope
//
//  Created by Savyo Brenner on 05/01/24.
//

import Moya
import SwiftUI

enum ContentDetailsEndpoint {
    case fetchContentDetails(id: String)
}

// MARK: - Endpoint Builder
extension ContentDetailsEndpoint: Endpoint {
    var requiresToken: Bool {
        return true
    }
    
    var baseURL: URL {
        URL(string: AppEnvironment.baseURL)!
    }
    
    var path: String {
        switch self {
        case let .fetchContentDetails(contentId):
            return "movie/\(contentId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchContentDetails:
            return .get
        }
    }
    
    private var parameters: [String: Any] {
        var params = [String: Any]()
        
        switch self {
        case .fetchContentDetails:
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
