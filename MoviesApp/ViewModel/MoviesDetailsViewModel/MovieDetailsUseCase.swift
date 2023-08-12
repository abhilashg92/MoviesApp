//
//  MovieDetailsUseCase.swift
//  MoviesApp
//
//  Created by Kiwi on 11/08/23.
//

import Foundation


protocol MovieDetailProtocol {
    func getMovieDetail(movieId: Int,
                        handler: @escaping (Result<MovieUIModel, MError>) -> Void)
}

final class MovieDetailUseCase: MovieDetailProtocol {
    
    let netWorkSerive: NetworkServiceProtocol
    init(netWorkSerive: NetworkServiceProtocol) {
        self.netWorkSerive = netWorkSerive
    }
    
    func getMovieDetail(movieId: Int,
                        handler: @escaping (Result<MovieUIModel, MError>) -> Void) {
        
        guard let url = URL(string: APIUrl().getMovieDetialsUrl() + "/\(movieId)" + APIUrl.apiKey + AppConstants.apiKey) else {
            handler(.failure(.unexpectedError))
            return
        }
        
        let req = URLRequest(url: url)
        netWorkSerive.callDataTask(request: req) { result in
            
            switch result {
            case .success(let data):
                do {
                    let moviesData = try JSONDecoder().decode(MovieDetail.self, from: data)
                    print(moviesData)
                    
                    let movieUIModel = MovieUIModel(id: moviesData.id ,
                                                    title: moviesData.title ,
                                                    thumbnail: moviesData.posterUrl() ,
                                                    overview: moviesData.overview ,
                                                    date: moviesData.releaseDate,
                                                    gernes: moviesData.genres.map {$0.name})
                    handler(.success(movieUIModel))
                } catch (let err) {
                    print(err.localizedDescription)
                    handler(.failure(MError.unexpectedError))
                }
                print(data)
            case .failure(let error):
                handler(.failure(error))
                print(error)
            }
        }
    }
}
