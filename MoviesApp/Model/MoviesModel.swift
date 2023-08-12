//
//  MoviesModel.swift
//  MoviesApp
//
//  Created by Kiwi on 11/08/23.
//

import Foundation

// MARK: - Movies UI Model

struct MovieUIModel: Identifiable {
    let id: Int?
    let title: String?
    let thumbnail: String?
    let overview: String?
    let date: String?
    let gernes: [String]?
}

// MARK: - Movies Response Models

struct MovieData: Codable {
    let results: [Movie]?
}

struct Movie: Codable,Identifiable {
    let adult: Bool?
    let backdrop_path: String?
    let id: Int?
    let genre_ids : [Int]?
    let original_title, overview: String?
    let popularity: Double?
    let poster_path, release_date, title: String?
    let video: Bool?
    let vote_average: Double?
    let vote_count: Int?
    
    func getThumbnailUrl() -> String {
        return APIUrl.thumbnailBase + (poster_path ?? "")
    }
}

struct Message: Identifiable, Codable {
    let id: Int
    var user: String
    var text: String
}

struct MovieDetail: Codable {
    let adult: Bool
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let revenue, runtime: Int
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    func posterUrl() -> String {
        return APIUrl.thumbnailBase + posterPath
    }
    enum CodingKeys: String, CodingKey {
        case adult
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue, runtime
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}
