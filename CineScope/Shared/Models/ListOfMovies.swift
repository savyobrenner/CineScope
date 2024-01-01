//
//  ListOfMovies.swift
//  CineScope
//
//  Created by Savyo Brenner on 01/01/24.
//

import Foundation

struct ListOfMovies: Codable {
    let page: Int?
    let results: [Movie]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
