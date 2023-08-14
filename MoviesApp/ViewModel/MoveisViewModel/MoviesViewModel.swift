//
//  MoviesViewModel.swift
//  MoviesApp
//
//  Created by Kiwi on 10/08/23.
//

import Foundation
import Combine

protocol MoviesProtocol: ObservableObject {
    func fetchPopulerMovies()
}

class MoviesViewModel: MoviesProtocol {
    
    @Published var movies: [MovieUIModel] = []
    @Published var errorText: String = ""
    @Published var searchText: String = ""
    
    private let netWorkService: NetworkServiceProtocol
    
    init(netWorkService: NetworkServiceProtocol) {
        self.netWorkService = netWorkService
    }
    
    func fetchMovies() {
        let useCase = SearchMoviesUseCase(netWorkSerive: netWorkService)
        useCase.searchMovies(searchText: searchText) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.errorText = movies.isEmpty ? Strings.searchMovies : ""
                    break
                case .failure(_):
                    self.movies.removeAll()
                    self.errorText = MError.parsingError.rawValue
                }
            }
        }
    }
    
    func fetchPopulerMovies() {
        let useCase = PopulerMoviesUseCase(netWorkSerive: netWorkService)
        useCase.searchMovies() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                    break
                case .failure(let err):
                    switch err {
                    case .parsingError, .unexpectedError:
                        self.errorText = err.rawValue
                        break
                    case .unAutherized:
                        self.errorText = err.rawValue
                        break
                    }
                    self.movies.removeAll()
                }
            }
        }
    }
}
