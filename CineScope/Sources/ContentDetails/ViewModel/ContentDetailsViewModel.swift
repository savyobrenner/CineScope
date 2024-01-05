//
//  ContentDetailsViewModel.swift
//  CineScope
//
//  Created by Savyo Brenner on 05/01/24.
//

import Foundation

final class ContentDetailsViewModel: ContentDetailsViewModelProtocol {
    
    private let router: Router
    private let contentDetailsServices: ContentDetailsServicesProtocol
    
    @Published var isLoading: Bool = false
    @Published var toastMessage: CSToastMessage?
    
    var relatedContent: [MediaModel] = []
    
    @Published var sections: [SectionModel] = []
    
    init(
        router: Router,
        contentDetailsServices: ContentDetailsServicesProtocol
    ) {
        self.router = router
        self.contentDetailsServices = contentDetailsServices
    }
    
    func fetchData() {
        
    }
}

private extension ContentDetailsViewModel {
    func fetchContentDetails() {
        isLoading = true
        contentDetailsServices.fetchContentDetails(for: "") { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(let success):
                if let contents = success.results {
                    let section = SectionModel(title: "More Like This".localized, items: contents, isHorizontal: true)
                    self?.sections.append(section)
                } else {
                    self?.toastMessage = .init(message: "Something went wrong, try again".localized, type: .error)
                }
            case .failure(let error):
                self?.toastMessage = .init(message: error.localizedDescription, type: .error)
            }
        }
    }
}
