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
    var movies: [Movie] { get }
    func fetchPopularMovies()
}
