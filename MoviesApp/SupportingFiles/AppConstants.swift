//
//  AppConstants.swift
//  MoviesApp
//
//  Created by Kiwi on 11/08/23.
//

import Foundation

struct AppConstants {
    static let apiKey = "c04cd6b4dd3fc9599bfd3edc85994b2b"
}

struct Strings {
    static let moviesTitle = "Populer Movies"
    static let releaseDate = "Released on: "
    static let loadingMovies = "Loading Populer Movies"
}

struct APIUrl {
    static let baseUrl = "https://api.themoviedb.org/3"
    static let movie = "/movie"
    static let apiKey = "?api_key="
    static let thumbnailBase = "https://image.tmdb.org/t/p/w500"
    static let populer = "/popular"
    
    func getPopulerMoviesUrl() -> String {
        return APIUrl.baseUrl + APIUrl.movie + APIUrl.populer + APIUrl.apiKey + AppConstants.apiKey
    }

    func getMovieDetialsUrl() -> String {
        return APIUrl.baseUrl + APIUrl.movie
    }
}

enum MError: Error {
    case parsingError
    case unexpectedError
    case unAutherized
}

