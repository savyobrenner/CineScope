//
//  AppEnviroment.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import SwiftUI

enum AppEnvironment {
    
    static var websiteURL: String {
        return "https://www.themoviedb.org"
    }
    
    static var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    static var imagesBaseURL: String {
        return UIDevice.current.userInterfaceIdiom == .phone ?
        "https://image.tmdb.org/t/p/w500/" :
        "https://image.tmdb.org/t/p/w780/"
    }
    
    static var userToken: String {
        // Add API key
        return ""
    }
    
    static var currentLanguageURLParameter: String {
        return "&language=\(Language.current.rawValue)"
    }
    
    static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0"
    }
    
    static var appBuildVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "0"
    }
}

