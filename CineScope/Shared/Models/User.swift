//
//  User.swift
//  CineScope
//
//  Created by Savyo Brenner on 01/01/24.
//

import Foundation

struct User: Codable {
    let uid: String?
    let name: String?
    let email: String?
    let photoURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case uid
        case name
        case email
        case photoURL = "photoUrl"
    }
}
