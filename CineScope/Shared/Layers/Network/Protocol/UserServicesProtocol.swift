//
//  UserServicesProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 03/01/24.
//

import SwiftUI

protocol UserServicesProtocol {
    func uploadProfileImage(_ image: UIImage,_ onResponse: @escaping (Result<User, CSError>) -> Void)
}
