//
//  HomeServicesProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 01/01/24.
//

import Foundation

protocol HomeServicesProtocol {
    func fetchPopularMovies(onSuccess: @escaping (Result<ListOfItems, CSError>) -> Void)
    func fetchTopRatedMovies(onSuccess: @escaping (Result<ListOfItems, CSError>) -> Void)
    func fetchPopularTVShows(onSuccess: @escaping (Result<ListOfItems, CSError>) -> Void)
    func fetchTopRatedTVShows(onSuccess: @escaping (Result<ListOfItems, CSError>) -> Void)
}
