//
//  NetworkService.swift
//  MoviesApp
//
//  Created by Kiwi on 11/08/23.
//

import Foundation

protocol NetworkServiceProtocol {
    func callDataTask(request: URLRequest,
                      handler: @escaping  (Result<Data, MError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    func callDataTask(request: URLRequest,
                      handler: @escaping (Result<Data, MError>) -> Void) {
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                handler(.failure(MError.unexpectedError))
                return
            }
            
            guard let responseData = data else {
                handler(.failure(MError.unexpectedError))
                return
            }
            guard let httpsResponse = response as? HTTPURLResponse else {
                return
            }
            
            switch httpsResponse.statusCode {
            case 200:
                handler(.success(responseData))
                break
            case 400...410:
                handler(.failure(MError.unAutherized))
                break
            default:
                handler(.failure(MError.unexpectedError))
                break
            }
            
        }.resume()
    }
}

