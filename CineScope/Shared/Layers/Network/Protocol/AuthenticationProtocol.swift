//
//  AuthenticationProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import Foundation

public protocol AuthenticationProtocol {
    func login(with email: String,
               and password: String,
               _ onResponse: @escaping (Result<String, CSError>) -> Void)
    func register(name: String,
                  email: String,
                  password: String,
                  _ onResponse: @escaping (Result<String, CSError>) -> Void)
}
