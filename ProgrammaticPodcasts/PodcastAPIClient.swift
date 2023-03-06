//
//  PodcastAPIClient.swift
//  ProgrammaticPodcasts
//
//  Created by Brendon Crowe on 3/6/23.
//

import Foundation
import NetworkHelper

struct PodcastAPIClient {
    static func fetchPodcasts(with name: String, completion: @escaping(Result<[Podcast], AppError>) -> ()) {
        let urlEndpoint = "https://itunes.apple.com/search?media=podcast&limit=200&term=\(name)"
        guard let url = URL(string: urlEndpoint) else {
            completion(.failure(.badURL(urlEndpoint)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { result in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let podcastSearch = try JSONDecoder().decode(PodcastSearch.self, from: data)
                    completion(.success(podcastSearch.results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
