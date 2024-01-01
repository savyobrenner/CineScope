//
//  ListOfItems.swift
//  CineScope
//
//  Created by Savyo Brenner on 01/01/24.
//

import Foundation

struct ListOfItems: Codable {
    let page: Int?
    let results: [MediaModel]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
