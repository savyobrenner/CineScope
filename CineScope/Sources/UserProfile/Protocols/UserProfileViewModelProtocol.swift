//
//  UserProfileViewModelProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 03/01/24.
//

import SwiftUI
import Combine

protocol UserProfileViewModelProtocol: ObservableObject {
    var isLoading: Bool { get }
    var toastMessage: CSToastMessage? { get set }
    var user: User? { get }
    var selectedImage: UIImage? { get set }
    var userUpdated: PassthroughSubject<Void, Never> { get set }
    func uploadProfileImage()
    func logout()
}
