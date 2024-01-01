//
//  HomeServicesProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 01/01/24.
//

import Foundation

protocol HomeServicesProtocol {
    func fetchPopularMovies(onSuccess: @escaping (Result<ListOfMovies, CSError>) -> Void)
}
