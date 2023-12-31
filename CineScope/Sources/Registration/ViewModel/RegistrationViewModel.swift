//
//  RegistrationViewModel.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

class RegistrationViewModel: RegistrationViewModelProtocol {
    
    private let authenticationService: AuthenticationProtocol
    
    init(authenticationService: AuthenticationProtocol) {
        self.authenticationService = authenticationService
    }
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""

    func register() {
        print("Registering with name: \(name), email: \(email), password: \(password)")
    }
}
