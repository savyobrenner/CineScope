//
//  RegistrationViewModel.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

class RegistrationViewModel: RegistrationViewModelProtocol {
    
    private let router: Router
    private let authenticationService: AuthenticationProtocol
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLoading: Bool = false
    
    @Published var toastMessage: CSToastMessage?
    
    init(authenticationService: AuthenticationProtocol, router: Router) {
        self.authenticationService = authenticationService
        self.router = router
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
            case .success:
                self?.router.navigate(to: .tabBar)
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
            toastMessage = .init(message: "Email cannot be empty.".localized, type: .info)
            return false
        }
        
        guard email.isValidEmail() else {
            toastMessage = .init(message: "Invalid email format.".localized, type: .info)
            return false
        }
        
        return true
    }
    
    func validatePassword() -> Bool {
        guard !password.isEmpty else {
            toastMessage = .init(message: "Password cannot be empty.".localized, type: .info)
            return false
        }
        
        guard password.isValidPassword() else {
            toastMessage = .init(message: "Password must be more than 5 characters.".localized, type: .info)
            return false
        }
        
        return true
    }
}
