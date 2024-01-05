//
//  ContentDetailsServicesProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 05/01/24.
//

import Foundation

protocol ContentDetailsServicesProtocol {
    func fetchMovieDetails(for contentId: String, onSuccess: @escaping (Result<MediaModel, CSError>) -> Void)
    func fetchTVShowsDetails(for contentId: String, onSuccess: @escaping (Result<MediaModel, CSError>) -> Void)
    func fetchRelatedMovies(for contentId: String, onSuccess: @escaping (Result<ListOfItems, CSError>) -> Void)
    func fetchRelatedTVShows(for contentId: String, onSuccess: @escaping (Result<ListOfItems, CSError>) -> Void)
}
