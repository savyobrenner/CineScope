//
//  FirebaseManager.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import Firebase
import FirebaseAuth
import FirebaseStorage

final class FirebaseManager: AuthenticationProtocol, UserServicesProtocol {
    
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
    
    func uploadProfileImage(_ image: UIImage, _ onResponse: @escaping (Result<User, CSError>) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = FirebaseStorage.Storage.storage().reference().child("user/\(uid)/profile.jpg")

        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }

        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"

        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if let error = error {
                onResponse(.failure(.init(message: .init(detail: error.localizedDescription))))
                return
            }

            storageRef.downloadURL { url, error in
                guard let url = url else {
                    onResponse(.failure(.init(message: .init(detail: error?.localizedDescription ?? ""))))
                    return
                }

                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.photoURL = url
                changeRequest?.commitChanges { error in
                    if let error = error {
                        onResponse(.failure(.init(message: .init(detail: error.localizedDescription))))
                    } else {
                        let firebaseUser = Auth.auth().currentUser
                        let user = User(
                            uid: firebaseUser?.uid,
                            name: firebaseUser?.displayName,
                            email: firebaseUser?.email,
                            photoURL: firebaseUser?.photoURL
                        )
                        
                        onResponse(.success(user))
                    }
                }
            }
        }
    }

}
