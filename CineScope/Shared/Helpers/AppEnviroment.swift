//
//  AppEnviroment.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Foundation

enum AppEnvironment {

    static var websiteURL: String {
        return "https://google.com.br"
    }
    
    static var baseURL: String {
        return "https://google.com.br"
    }
    
    static var appVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "0"
    }
    
    static var appBuildVersion: String {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "0"
    }
}

