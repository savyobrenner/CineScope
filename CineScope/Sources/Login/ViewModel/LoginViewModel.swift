//
//  LoginViewModel.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

final class LoginViewModel: LoginViewModelProtocol {
    
    private let router: Router
    private let authenticationService: AuthenticationProtocol
    private let serviceLocator: ServiceLocatorProtocol
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLoading: Bool = false
    
    @Published var toastMessage: CSToastMessage?
    
    init(
        authenticationService: AuthenticationProtocol,
        router: Router,
        serviceLocator: ServiceLocatorProtocol
    ) {
        self.authenticationService = authenticationService
        self.router = router
        self.serviceLocator = serviceLocator
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
            case let .success(response):
                try? self?.serviceLocator.cacheManager.save(response, for: .user)
                self?.router.navigate(to: .tabBar)
            case let .failure(error):
                self?.toastMessage = .init(message: error.localizedDescription, type: .error)
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
