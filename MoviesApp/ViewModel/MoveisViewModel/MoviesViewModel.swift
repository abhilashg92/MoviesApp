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
    
    private let netWorkService: NetworkServiceProtocol
    
    init(netWorkService: NetworkServiceProtocol) {
        self.netWorkService = netWorkService
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
                        self.errorText = "Something went wrong please try again leter"
                        break
                    case .unAutherized:
                        self.errorText = "You are not authorized to make this request."
                        break
                    }
                    self.movies.removeAll()
                }
            }
        }
    }
}
