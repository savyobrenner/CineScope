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
    
    func fetchPopularMovies(onSuccess: @escaping (Result<ListOfMovies, CSError>) -> Void) {
        network.request(HomeEndpoint.fetchPopularMovies, expectedType: ListOfMovies.self, onSuccess)
    }
}
