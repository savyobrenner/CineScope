//
//  RegistrationViewModelProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 31/12/23.
//

import SwiftUI

protocol RegistrationViewModelProtocol: ObservableObject {
    var name: String { get set }
    var email: String { get set }
    var password: String { get set }
    func register()
}
