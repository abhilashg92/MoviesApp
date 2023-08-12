//
//  MoviesDetailsViewModel.swift
//  MoviesApp
//
//  Created by Kiwi on 11/08/23.
//

import Foundation


protocol GetMoviesDetailsProtocol: ObservableObject {
    func getMovieDetails(id: Int)
}

class MoviesDetailsViewModel: GetMoviesDetailsProtocol {
    
    @Published var movie: MovieUIModel?
    
    private let netWorkService: NetworkServiceProtocol
    
    init(netWorkService: NetworkServiceProtocol) {
        self.netWorkService = netWorkService
    }
    
    func getMovieDetails(id: Int) {
        let useCase = MovieDetailUseCase(netWorkSerive: netWorkService)
        useCase.getMovieDetail(movieId: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    print(data)
                    self.movie = data
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
