//
//  ContentDetailsEndpoint.swift
//  CineScope
//
//  Created by Savyo Brenner on 05/01/24.
//

import Moya
import SwiftUI

enum ContentDetailsEndpoint {
    case fetchMovieDetails(id: String)
    case fetchTVShowDetails(id: String)
    case fetchRelatedMovies(id: String)
    case fetchRelatedTVShows(id: String)
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
        case let .fetchMovieDetails(contentId):
            return "movie/\(contentId)"
        case let .fetchTVShowDetails(contentId):
            return "tv/\(contentId)"
        case let .fetchRelatedMovies(id):
            return "movie/\(id)/similar"
        case let .fetchRelatedTVShows(id):
            return "tv/\(id)/similar"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case
                .fetchMovieDetails,
                .fetchTVShowDetails,
                .fetchRelatedMovies,
                .fetchRelatedTVShows:
            return .get
        }
    }
    
    private var parameters: [String: Any] {
        var params = [String: Any]()
        
        switch self {
        case
                .fetchMovieDetails,
                .fetchTVShowDetails, 
                .fetchRelatedMovies,
                .fetchRelatedTVShows:
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
