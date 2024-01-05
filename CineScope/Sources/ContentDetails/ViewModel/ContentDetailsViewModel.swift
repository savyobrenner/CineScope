//
//  ContentDetailsViewModel.swift
//  CineScope
//
//  Created by Savyo Brenner on 05/01/24.
//

import SwiftUI

final class ContentDetailsViewModel: ContentDetailsViewModelProtocol {
    
    private let router: Router
    private let contentDetailsServices: ContentDetailsServicesProtocol
    private let contentId: String
    private let isMovie: Bool
    
    @Published var isLoading: Bool = false
    @Published var toastMessage: CSToastMessage?
    @Published var contentDetails: MediaModel?
    @Published var relatedContent: [MediaModel] = []
    @Published var sections: [SectionModel] = []
    
    var runtime: String {
        return formattedRuntime()
    }
    
    var releaseDate: String {
        return formattedReleaseDate()
    }
    
    var genresString: String {
        return formattedGenres()
    }
    
    private var contentGenres: [Genre] = []
    
    init(
        router: Router,
        contentDetailsServices: ContentDetailsServicesProtocol,
        contentId: String,
        isMovie: Bool
    ) {
        self.router = router
        self.contentDetailsServices = contentDetailsServices
        self.contentId = contentId
        self.isMovie = isMovie
    }
    
    func fetchData() {
        isLoading = true
        let fetchGroup = DispatchGroup()
        
        fetchGroup.enter()
        fetchContentGenres {
            fetchGroup.leave()
        }
        
        fetchGroup.enter()
        fetchContentDetails {
            fetchGroup.leave()
        }
        
        fetchGroup.enter()
        fetchRelatedContent {
            fetchGroup.leave()
        }
        
        fetchGroup.notify(queue: .main) {
            self.isLoading = false
        }
    }
}

private extension ContentDetailsViewModel {
    func fetchContentGenres(completion: @escaping () -> Void) {
        guard isMovie else {
            contentDetailsServices.fetchTVShowGenres { [weak self] result in
                completion()
                switch result {
                case .success(let success):
                    self?.contentGenres = success.genres ?? []
                case .failure(let error):
                    self?.toastMessage = .init(message: error.localizedDescription, type: .error)
                }
            }
            return
        }
        
        contentDetailsServices.fetchMoviesGenres { [weak self] result in
            completion()
            switch result {
            case .success(let success):
                self?.contentGenres = success.genres ?? []
            case .failure(let error):
                self?.toastMessage = .init(message: error.localizedDescription, type: .error)
            }
        }
    }
    
    func fetchContentDetails(completion: @escaping () -> Void) {
        guard isMovie else {
            contentDetailsServices.fetchTVShowsDetails(for: contentId) { [weak self] result in
                completion()
                switch result {
                case .success(let success):
                    self?.contentDetails = success
                case .failure(let error):
                    self?.toastMessage = .init(message: error.localizedDescription, type: .error)
                }
            }
            return
        }
        
        contentDetailsServices.fetchMovieDetails(for: contentId) { [weak self] result in
            completion()
            switch result {
            case .success(let success):
                self?.contentDetails = success
            case .failure(let error):
                self?.toastMessage = .init(message: error.localizedDescription, type: .error)
            }
        }
    }
    
    func fetchRelatedContent(completion: @escaping () -> Void) {
        guard isMovie else {
            contentDetailsServices.fetchRelatedTVShows(for: contentId) { [weak self] result in
                completion()
                switch result {
                case .success(let success):
                    self?.createRelatedContentSection(with: success)
                case .failure(let error):
                    self?.toastMessage = .init(message: error.localizedDescription, type: .error)
                }
            }
            return
        }
        
        contentDetailsServices.fetchRelatedMovies(for: contentId) { [weak self] result in
            completion()
            switch result {
            case .success(let success):
                self?.createRelatedContentSection(with: success)
            case .failure(let error):
                self?.toastMessage = .init(message: error.localizedDescription, type: .error)
            }
        }
    }
    
    func createRelatedContentSection(with list: ListOfItems) {
        if let contents = list.results {
            let section = SectionModel(
                title: "More Like This".localized,
                items: contents,
                isHorizontal: true,
                isMovie: isMovie)
            sections.append(section)
        } else {
            toastMessage = .init(message: "Something went wrong, try again".localized, type: .error)
        }
    }
    
    func formattedRuntime() -> String {
        guard let runtime = contentDetails?.runtime else { return "N/A" }
        let hours = runtime / 60
        let minutes = runtime % 60
        return "\(hours)h \(minutes)m"
    }

    func formattedReleaseDate() -> String {
        guard let releaseDate = contentDetails?.releaseDate else { return "N/A" }
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"

        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMMM dd, yyyy"

        if let date = dateFormatterGet.date(from: releaseDate) {
            return dateFormatterPrint.string(from: date)
        } else {
            return "N/A"
        }
    }

    func formattedGenres() -> String {
        guard let ids = contentDetails?.genreIDS else { return "N/A" }
        
        let genres = contentGenres.filter { ids.contains($0.id ?? 0) }
        let firstThreeGenres = genres.prefix(3)
        return firstThreeGenres.map { $0.name ?? "" }.joined(separator: " - ")
    }
}
