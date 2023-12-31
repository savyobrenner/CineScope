//
//  FirebaseManager.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import FirebaseAuth

final class FirebaseManager: AuthenticationProtocol {
    
    func login(with email: String, and password: String, _ onResponse: @escaping (Result<String, CSError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error, let code = error.asAFError?.responseCode {
                let customError = CSError(statusCode: code, message: .init(detail: error.localizedDescription))
                onResponse(.failure(customError))
            } else {
                onResponse(.success(result?.user.uid ?? ""))
            }
        }
    }
    
    func register(name: String, email: String, password: String, _ onResponse: @escaping (Result<String, CSError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error, let code = error.asAFError?.responseCode {
                let customError = CSError(statusCode: code, message: .init(detail: error.localizedDescription))
                onResponse(.failure(customError))
            } else {
                onResponse(.success(result?.user.uid ?? ""))
            }
        }
    }
}
