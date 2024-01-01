//
//  AuthenticationProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import Foundation

protocol AuthenticationProtocol {
    func login(with email: String,
               and password: String,
               _ onResponse: @escaping (Result<User, CSError>) -> Void)
    func register(name: String,
                  email: String,
                  password: String,
                  _ onResponse: @escaping (Result<User, CSError>) -> Void)
}
