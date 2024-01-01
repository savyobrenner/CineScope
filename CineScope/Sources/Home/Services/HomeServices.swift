//
//  HomeServices.swift
//  CineScope
//
//  Created by Savyo Brenner on 01/01/24.
//

import Foundation

class HomeServices: HomeServicesProtocol {
    private var network: NetworkProtocol
    
    public init(network: NetworkProtocol) {
        self.network = network
    }
    
    func fetchPopularMovies(onSuccess: @escaping (Result<ListOfItems, CSError>) -> Void) {
        network.request(HomeEndpoint.fetchPopularMovies, expectedType: ListOfItems.self, onSuccess)
    }
    
    func fetchTopRatedMovies(onSuccess: @escaping (Result<ListOfItems, CSError>) -> Void) {
        network.request(HomeEndpoint.fetchTopRatedMovies, expectedType: ListOfItems.self, onSuccess)
    }
    
    func fetchPopularTVShows(onSuccess: @escaping (Result<ListOfItems, CSError>) -> Void) {
        network.request(HomeEndpoint.fetchPopularTVShows, expectedType: ListOfItems.self, onSuccess)
    }
    
    func fetchTopRatedTVShows(onSuccess: @escaping (Result<ListOfItems, CSError>) -> Void) {
        network.request(HomeEndpoint.fetchTopRatedTVShows, expectedType: ListOfItems.self, onSuccess)
    }
}
