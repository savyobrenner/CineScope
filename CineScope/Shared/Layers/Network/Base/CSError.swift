//
//  CSError.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Foundation

public struct CSError: Error, Codable {
    var statusCode: Int?
    var message: CSErrorMessage?
}


struct CSErrorMessage: Codable {
    var detail: String?
}

