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
    var contents: [MediaModel] = []
    
    var user: User? {
        serviceLocator.userSettings.user
    }
    
    @Published var sections: [SectionModel] = []

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
                if let contents = success.results {
                    self?.contents = contents
                    self?.sections = [.init(title: "Popular Movies".localized, items: contents, horizontal: true)]
                    return
                }
                
                self?.toastMessage = .init(message: "Something went wrong, try again".localized, type: .error)
            case .failure(let error):
                self?.toastMessage = .init(message: error.localizedDescription, type: .error)
            }
        }
    }
}
