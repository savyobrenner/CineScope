//
//  NetworkProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 30/12/23.
//

import Foundation

public protocol NetworkProtocol {
    func request<T: Codable, U: Endpoint>(
        _ endpoint: U, expectedType: T.Type,
        _ onResponse: @escaping (Result<T, LSError>) -> Void
    )
}

