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
    var contents: [MediaModel] { get }
    var user: User? { get }
    var sections: [SectionModel] { get set }
    func fetchPopularMovies()
}
