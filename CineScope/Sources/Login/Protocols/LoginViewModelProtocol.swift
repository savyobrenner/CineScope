//
//  LoginViewModelProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

protocol LoginViewModelProtocol: ObservableObject {
    var email: String { get set }
    var password: String { get set }
    var isLoading: Bool { get set }
    var toastMessage: CSToastMessage? { get set }
    func registrationButtonWasPressed()
    func navigateToHome()
    func login()
}
