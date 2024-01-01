//
//  FirebaseManager.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import FirebaseAuth

final class FirebaseManager: AuthenticationProtocol {
    
    func login(with email: String, and password: String, _ onResponse: @escaping (Result<User, CSError>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error, let code = error.asAFError?.responseCode {
                let customError = CSError(statusCode: code, message: .init(detail: error.localizedDescription))
                onResponse(.failure(customError))
            } else {
                guard let firebaseUser = result?.user else {
                    onResponse(.failure(.init()))
                    return
                }
                
                let user = User(
                    uid: firebaseUser.uid,
                    name: firebaseUser.displayName,
                    email: firebaseUser.email,
                    photoURL: firebaseUser.photoURL
                )
                
                onResponse(.success(user))
            }
        }
    }
    
    func register(name: String, email: String, password: String, _ onResponse: @escaping (Result<User, CSError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                let customError = CSError(message: .init(detail: error.localizedDescription))
                onResponse(.failure(customError))
            } else if let firebaseUser = result?.user {
                let changeRequest = firebaseUser.createProfileChangeRequest()
                changeRequest.displayName = name
                changeRequest.commitChanges { error in
                    if let error = error {
                        let customError = CSError(message: .init(detail: error.localizedDescription))
                        onResponse(.failure(customError))
                    } else {
                        
                        let user = User(
                            uid: firebaseUser.uid,
                            name: firebaseUser.displayName,
                            email: firebaseUser.email,
                            photoURL: firebaseUser.photoURL
                        )
                        
                        onResponse(.success(user))
                    }
                }
            }
        }
    }
}
