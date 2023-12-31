//
//  RegistrationViewModel.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

class RegistrationViewModel: RegistrationViewModelProtocol {
    
    @EnvironmentObject var router: Router
    private let authenticationService: AuthenticationProtocol
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLoading: Bool = false
    
    @Published var toastMessage: CSToastMessage?
    
    init(authenticationService: AuthenticationProtocol) {
        self.authenticationService = authenticationService
    }
    
    func register() {
        clearErrorMessages()
        
        guard validateName(), validateEmail(), validatePassword() else {
            return
        }
        
        isLoading = true
        authenticationService.register(
            name: name,
            email: email,
            password: password
        ) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let success):
                router.navigate(to: .tabBar)
            case .failure(let failure):
                self?.toastMessage = .init(message: failure.localizedDescription, type: .error)
            }
        }
    }
}

private extension RegistrationViewModel {
    
    func clearErrorMessages() {
        toastMessage = nil
    }
    
    func validateName() -> Bool {
        guard !name.isEmpty else {
            toastMessage = .init(message: "Name cannot be empty.", type: .info)
            return false
        }
        return true
    }
    
    func validateEmail() -> Bool {
        guard !email.isEmpty else {
            toastMessage = .init(message: "Email cannot be empty.", type: .info)
            return false
        }
        
        guard email.isValidEmail() else {
            toastMessage = .init(message: "Invalid email format.", type: .info)
            return false
        }
        
        return true
    }
    
    func validatePassword() -> Bool {
        guard !password.isEmpty else {
            toastMessage = .init(message: "Password cannot be empty.", type: .info)
            return false
        }
        
        guard password.isValidPassword() else {
            toastMessage = .init(message: "Password must be more than 5 characters.", type: .info)
            return false
        }
        
        return true
    }
}
