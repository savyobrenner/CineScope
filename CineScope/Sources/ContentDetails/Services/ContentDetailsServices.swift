//
//  ContentDetailsServices.swift
//  CineScope
//
//  Created by Savyo Brenner on 05/01/24.
//

import Foundation

class ContentDetailsServices: ContentDetailsServicesProtocol {
    private var network: NetworkProtocol
    
    public init(network: NetworkProtocol) {
        self.network = network
    }
    
    func fetchMovieDetails(for contentId: String, onSuccess: @escaping (Result<MediaModel, CSError>) -> Void) {
        network.request(
            ContentDetailsEndpoint.fetchMovieDetails(id: contentId),
            expectedType: MediaModel.self,
            onSuccess
        )
    }
    
    func fetchTVShowsDetails(for contentId: String, onSuccess: @escaping (Result<MediaModel, CSError>) -> Void) {
        network.request(
            ContentDetailsEndpoint.fetchTVShowDetails(id: contentId),
            expectedType: MediaModel.self,
            onSuccess
        )
    }
    
    func fetchRelatedMovies(for contentId: String, onSuccess: @escaping (Result<ListOfItems, CSError>) -> Void) {
        network.request(
            ContentDetailsEndpoint.fetchRelatedMovies(id: contentId),
            expectedType: ListOfItems.self,
            onSuccess
        )
    }
    
    func fetchRelatedTVShows(for contentId: String, onSuccess: @escaping (Result<ListOfItems, CSError>) -> Void) {
        network.request(
            ContentDetailsEndpoint.fetchRelatedTVShows(id: contentId),
            expectedType: ListOfItems.self,
            onSuccess
        )
    }
}
