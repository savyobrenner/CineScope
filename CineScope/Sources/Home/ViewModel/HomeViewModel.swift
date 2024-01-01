//
//  HomeViewModel.swift
//  CineScope
//
//  Created by Savyo Brenner on 01/01/24.
//

import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    private let router: Router
    private let homeServices: HomeServicesProtocol
    private let serviceLocator: ServiceLocatorProtocol
    
    var isLoading: Bool = false
    var toastMessage: CSToastMessage?
    var movies: [Movie] = []
    
    var user: User? {
        serviceLocator.userSettings.user
    }
    
    init(
        homeServices: HomeServicesProtocol,
        router: Router,
        serviceLocator: ServiceLocatorProtocol
    ) {
        self.homeServices = homeServices
        self.router = router
        self.serviceLocator = serviceLocator
    }
    
    func fetchPopularMovies() {
        isLoading = true
        homeServices.fetchPopularMovies { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let success):
                if let movies = success.results {
                    self?.movies = movies
                    return
                }
                self?.toastMessage = .init(message: "Something went wrong, try again".localized, type: .error)
            case .failure(let error):
                self?.toastMessage = .init(message: error.localizedDescription, type: .error)
            }
        }
    }
}
