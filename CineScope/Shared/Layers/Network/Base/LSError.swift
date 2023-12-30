//
//  LSError.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Foundation

public struct LSError: Error, Codable {
    var statusCode: Int?
    var message: LSErrorMessage?
}


struct LSErrorMessage: Codable {
    let code: Int?
    var detail: String?
    var reason: String?
}

