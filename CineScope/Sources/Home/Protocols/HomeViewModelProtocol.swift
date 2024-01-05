//
//  HomeViewModelProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 01/01/24.
//

import Foundation

protocol HomeViewModelProtocol: ObservableObject {
    var isLoading: Bool { get }
    var toastMessage: CSToastMessage? { get set }
    var popularMovies: [MediaModel] { get }
    var topRatedMovies: [MediaModel] { get }
    var popularTVShows: [MediaModel] { get }
    var topRatedTVShows: [MediaModel] { get }
    var user: User? { get }
    var sections: [SectionModel] { get set }
    var selectedContent: MediaModel? { get set }
    func fetchData()
    func selectContentPreview(for media: MediaModel?)
    func profilePictureWasPressed()
    func goToContentDetails(id: String, isMovie: Bool)
}
