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
    
    func fetchContentDetails(for contentId: String, onSuccess: @escaping (Result<ListOfItems, CSError>) -> Void) {
        network.request(
            ContentDetailsEndpoint.fetchContentDetails(id: contentId),
            expectedType: ListOfItems.self,
            onSuccess
        )
    }
}
