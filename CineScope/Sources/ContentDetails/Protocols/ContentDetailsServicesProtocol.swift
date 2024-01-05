//
//  ContentDetailsServicesProtocol.swift
//  CineScope
//
//  Created by Savyo Brenner on 05/01/24.
//

import Foundation

protocol ContentDetailsServicesProtocol {
    func fetchContentDetails(for contentId: String, onSuccess: @escaping (Result<ListOfItems, CSError>) -> Void)
}
