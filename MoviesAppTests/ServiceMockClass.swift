//
//  ServiceMockClass.swift
//  MoviesAppTests
//
//  Created by Kiwi on 12/08/23.
//

import Foundation
@testable import MoviesApp

class MockService: NetworkServiceProtocol {
    var success = true

    func callDataTask(request: URLRequest,
                      handler: @escaping (Result<Data, MoviesApp.MError>) -> Void) {
        if success {
            let jsonData = Data(json.utf8)
            handler(.success(jsonData))
        } else {
            handler(.failure(.parsingError))
        }
    }
}

let json = """
{
    "page": 1,
    "results": [
        {
            "adult": false,
            "backdrop_path": "/mV1HOCbUqx7nfFPwledYsvMYHrw.jpg",
            "genre_ids": [
                28,
                53
            ],
            "id": 47964,
            "original_language": "en",
            "original_title": "A Good Day to Die Hard",
            "overview": "Iconoclastic, take-no-prisoners cop John McClane, finds himself for the first time on foreign soil after traveling to Moscow to help his wayward son Jack - unaware that Jack is really a highly-trained CIA operative out to stop a nuclear weapons heist. With the Russian underworld in pursuit, and battling a countdown to war, the two McClanes discover that their opposing methods make them unstoppable heroes.",
            "popularity": 360.823,
            "poster_path": "/evxtv4e8Amm436Y5rW16RkGu8pX.jpg",
            "release_date": "2013-02-06",
            "title": "A Good Day to Die Hard",
            "video": false,
            "vote_average": 5.315,
            "vote_count": 5969
        },
        {
            "adult": false,
            "backdrop_path": null,
            "genre_ids": [
                18
            ],
            "id": 916683,
            "original_language": "jv",
            "original_title": "Har",
            "overview": "Indonesia 1998, Har, a lonesome boy, waiting for his mother who works as a domestic worker in Hong Kong coming back home in a few days. Har life with his jobless father who busy helping the village authorities preparing the first electricity installation in his village. Meanwhile, far from Har village, the big thing happening: chaotic people all around the Capital to depose the dictator president in the era.",
            "popularity": 0.6,
            "poster_path": "/eI5ZlrMXa7G69IptgWpKNf5rIGl.jpg",
            "release_date": "2018-12-05",
            "title": "Har",
            "video": false,
            "vote_average": 6.5,
            "vote_count": 2
        },
        {
            "adult": false,
            "backdrop_path": "/bnRi1BB6d67fAoTSHm13ypFdf3r.jpg",
            "genre_ids": [
                35,
                10749
            ],
            "id": 884605,
            "original_language": "en",
            "original_title": "No Hard Feelings",
            "overview": "On the brink of losing her childhood home, Maddie discovers an intriguing job listing: wealthy helicopter parents looking for someone to “date” their introverted 19-year-old son, Percy, before he leaves for college. To her surprise, Maddie soon discovers the awkward Percy is no sure thing.",
            "popularity": 218.55,
            "poster_path": "/5xeNPGbM8ImVdJACUoGpXT8Pxx3.jpg",
            "release_date": "2023-06-15",
            "title": "No Hard Feelings",
            "video": false,
            "vote_average": 6.754,
            "vote_count": 211
        }]
}
"""
