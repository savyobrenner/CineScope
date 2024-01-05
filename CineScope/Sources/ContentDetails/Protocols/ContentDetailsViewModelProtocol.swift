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
    var relatedContent: [MediaModel] { get }
    var sections: [SectionModel] { get set }
    func fetchData()
}
