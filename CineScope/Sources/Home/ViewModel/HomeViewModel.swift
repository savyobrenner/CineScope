//
//  HomeViewModel.swift
//  CineScope
//
//  Created by Savyo Brenner on 01/01/24.
//

import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    
    enum MediaCategory {
        case popularMovies, topRatedMovies, popularTVShows, topRatedTVShows
    }
    
    private let router: Router
    private let homeServices: HomeServicesProtocol
    private let serviceLocator: ServiceLocatorProtocol
    
    @Published var isLoading: Bool = false
    @Published var toastMessage: CSToastMessage?
    @Published var selectedContent: MediaModel?
    
    var popularMovies: [MediaModel] = []
    var topRatedMovies: [MediaModel] = []
    var popularTVShows: [MediaModel] = []
    var topRatedTVShows: [MediaModel] = []
    
    var user: User? {
        serviceLocator.userSettings.user
    }
    
    @Published var sections: [SectionModel] = []
    
    private var loadingTasksCount = 0 {
        didSet {
            isLoading = loadingTasksCount > 0
        }
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
    
    func fetchData() {
        loadingTasksCount = 4
        fetchPopularMovies()
        fetchTopRatedMovies()
        fetchPopularTVShows()
        fetchTopRatedTVShows()
    }
    
    func selectContentPreview(for media: MediaModel?) {
        self.selectedContent = media
    }
    
    func profilePictureWasPressed() {
        router.navigate(to: .userSettings)
    }
    
    func goToContentDetails(id: String, isMovie: Bool) {
        router.navigate(to: .contentDetails(id: id, isMovie: isMovie))
    }
}

private extension HomeViewModel {
    func handleFetchResult(_ result: Result<ListOfItems, CSError>, for category: MediaCategory) {
        switch result {
        case .success(let success):
            if let contents = success.results {
                updateDataAndSections(with: contents, for: category)
            } else {
                toastMessage = .init(message: "Something went wrong, try again".localized, type: .error)
            }
        case .failure(let error):
            toastMessage = .init(message: error.localizedDescription, type: .error)
        }
    }
    
    func updateDataAndSections(with contents: [MediaModel], for category: MediaCategory) {
        switch category {
        case .popularMovies:
            popularMovies = contents
            selectedContent = contents.first
            let section = SectionModel(
                title: "Popular Movies".localized,
                items: contents,
                isHorizontal: true,
                isMovie: true
            )
            
            addOrUpdateSection(section, for: category, in: 0)
        case .topRatedMovies:
            topRatedMovies = contents
            let section = SectionModel(
                title: "Top Rated Movies".localized,
                items: contents, isHorizontal: false,
                isMovie: true
            )
            
            addOrUpdateSection(section, for: category, in: 1)
        case .popularTVShows:
            popularTVShows = contents
            let section = SectionModel(
                title: "Popular TV Shows".localized,
                items: contents,
                isHorizontal: false,
                isMovie: false
                
            )
            addOrUpdateSection(section, for: category, in: 2)
        case .topRatedTVShows:
            topRatedTVShows = contents
            let section = SectionModel(
                title: "Top Rated TV Shows".localized,
                items: contents,
                isHorizontal: false,
                isMovie: false
            )
            
            addOrUpdateSection(section, for: category, in: 3)
        }
    }
    
    func fetchPopularMovies() {
        homeServices.fetchPopularMovies { [weak self] result in
            defer { self?.loadingTasksCount -= 1 }
            self?.handleFetchResult(result, for: .popularMovies)
        }
    }
    
    func fetchTopRatedMovies() {
        homeServices.fetchTopRatedMovies { [weak self] result in
            defer { self?.loadingTasksCount -= 1 }
            self?.handleFetchResult(result, for: .topRatedMovies)
        }
    }
    
    func fetchPopularTVShows() {
        homeServices.fetchPopularTVShows { [weak self] result in
            defer { self?.loadingTasksCount -= 1 }
            self?.handleFetchResult(result, for: .popularTVShows)
        }
    }
    
    func fetchTopRatedTVShows() {
        homeServices.fetchTopRatedTVShows { [weak self] result in
            defer { self?.loadingTasksCount -= 1 }
            self?.handleFetchResult(result, for: .topRatedTVShows)
        }
    }
    
    func addOrUpdateSection(_ section: SectionModel, for category: MediaCategory, in index: Int) {
        DispatchQueue.main.async {
            if let sectionIndex = self.sections.firstIndex(where: { $0.title == section.title }) {
                self.sections[sectionIndex] = section
            } else {
                if self.sections.indices.contains(index) {
                    self.sections.insert(section, at: index)
                } else {
                    self.sections.append(section)
                }
            }
        }
    }
}
