//
//  Movie.swift
//  CineScope
//
//  Created by Savyo Brenner on 01/01/24.
//

import Foundation

struct MediaModel: Codable, Identifiable, Equatable {
    let uuid = UUID()
    let adult: Bool?
    let name: String?
    let backdropPath: String?
    let genreIDS: [Int]?
    let genres: [Genre]?
    let id: Int?
    let runtime: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case name
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case genres
        case id
        case runtime
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    var posterPathURL: URL? {
        return URL(string: AppEnvironment.imagesBaseURL + (posterPath ?? ""))
    }
    
    var backdropPathURL: URL? {
        return URL(string: AppEnvironment.imagesBaseURL + (backdropPath ?? ""))
    }
}

// MARK: - Genre
struct Genre: Codable, Equatable {
    let id: Int?
    let name: String?
}
