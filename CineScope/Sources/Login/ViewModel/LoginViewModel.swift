//
//  LoginViewModel.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

class LoginViewModel: LoginViewModelProtocol {
    
    private let router: Router
    private let authenticationService: AuthenticationProtocol
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLoading: Bool = false
    
    @Published var toastMessage: CSToastMessage?
    
    init(authenticationService: AuthenticationProtocol, router: Router) {
        self.authenticationService = authenticationService
        self.router = router
    }
    
    func login() {
        clearErrorMessages()
        
        guard validateEmail(), validatePassword() else {
            return
        }
        
        isLoading = true
        authenticationService.login(
            with: email,
            and: password
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
    
    func navigateToRegistration() {
        router.navigate(to: .registration)
    }
    
    func navigateToHome() {
        router.navigate(to: .tabBar)
    }
}

private extension LoginViewModel {
    
    func clearErrorMessages() {
        toastMessage = nil
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
