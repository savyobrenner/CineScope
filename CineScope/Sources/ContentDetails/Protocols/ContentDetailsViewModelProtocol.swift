//
//  ContentDetailsViewModelProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 05/01/24.
//

import Foundation

protocol ContentDetailsViewModelProtocol: ObservableObject {
    var isLoading: Bool { get }
    var toastMessage: CSToastMessage? { get set }
    var contentDetails: MediaModel? { get }
    var relatedContent: [MediaModel] { get }
    var sections: [SectionModel] { get set }
    var runtime: String { get }
    var releaseDate: String { get }
    var genresString: String { get }
    var startRating: Int { get }
    func fetchData()
}
