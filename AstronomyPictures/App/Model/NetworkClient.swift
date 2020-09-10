//
//  NetworkClient.swift
//  AstronomyPictures
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import Foundation

class NetworkClient: Client {
    
    func fetch(path: String, queryItems: [URLQueryItem], completion: @escaping (Result<Data, Error>) -> Void) {
        guard let validURL = generateBaseURLWith(path: path, queryItems: queryItems) else {
            return
        }

        URLSession.shared.dataTask(with: validURL) { (data, response, error) in
            guard let validData = data, error == nil else {
                completion(.failure(error!))
                return
            }
            completion(.success(validData))
        }.resume()
    }

    private func generateBaseURLWith(path: String, queryItems: [URLQueryItem]) -> URL? {
        var baseQueryItems = [URLQueryItem(name: "api_key", value: "OpbRVwB4Vt60g0tcM0EBMRHiAfgUb7q0gLAYJC9N")]
        baseQueryItems.append(contentsOf: queryItems)
        var componentURL = URLComponents()
        componentURL.scheme = "https"
        componentURL.host = "api.nasa.gov"
        componentURL.path = "/\(path)"
        componentURL.queryItems = baseQueryItems

        return componentURL.url
    }
}
