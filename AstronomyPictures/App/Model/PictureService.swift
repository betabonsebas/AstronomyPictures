//
//  PictureDataService.swift
//  AstronomyPictures
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import Foundation

class PictureService: Service {
    var client: Client
    private let group = DispatchGroup()

    init(client: Client = NetworkClient()) {
        self.client = client
    }

    func fetch<T>(for date: String, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
        var queryItems: [URLQueryItem] = []
        queryItems.append(URLQueryItem(name: "hd", value: "true"))
        queryItems.append(URLQueryItem(name: "date", value: date))
        client.fetch(path: "planetary/apod", queryItems: queryItems) { result in
            switch result {
            case .success(let data):
                let model = try? JSONDecoder().decode(T.self, from: data)
                guard let validModel = model else {
                    completion(.failure("Error parsing data"))
                    return
                }
                completion(.success(validModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
