//
//  UserProfileViewModel.swift
//  CineScope
//
//  Created by Savyo Brenner on 03/01/24.
//

import SwiftUI
import Combine

final class UserProfileViewModel: UserProfileViewModelProtocol {
    
    private let router: Router
    private let userServices: UserServicesProtocol
    private let serviceLocator: ServiceLocatorProtocol
    
    var userUpdated = PassthroughSubject<Void, Never>()
    
    @Published var isLoading: Bool = false
    @Published var toastMessage: CSToastMessage?
    @Published var selectedImage: UIImage? {
        didSet {
            uploadProfileImage()
        }
    }
    
    var user: User? {
        serviceLocator.userSettings.user
    }
    
    init(
        userServices: UserServicesProtocol,
        router: Router,
        serviceLocator: ServiceLocatorProtocol
    ) {
        self.userServices = userServices
        self.router = router
        self.serviceLocator = serviceLocator
    }
    
    func uploadProfileImage() {
        guard let image = selectedImage else { return }
        isLoading = true
        userServices.uploadProfileImage(image) {[weak self] result in
            self?.isLoading = false
            switch result {
            case let .success(response):
                self?.toastMessage = .init(message: "Profile picture updated!".localized, type: .success)
                try? self?.serviceLocator.cacheManager.save(response, for: .user)
                self?.userUpdated.send()
            case let .failure(error):
                self?.toastMessage = .init(message: error.localizedDescription, type: .error)
            }
        }
    }
    
    func logout() {
        do {
            try serviceLocator.cacheManager.remove(type: User.self, for: .user)
            router.navigate(to: .login)
        } catch {
            toastMessage = .init(message: "Failed to log out, please try again".localized, type: .error)
        }
    }
}
