//
//  MockNetworkClient.swift
//  AstronomyPicturesTests
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import Foundation
@testable import AstronomyPictures

class MockNetworkClient: Client {
    func fetch(path: String, queryItems: [URLQueryItem], completion: @escaping (Result<Data, Error>) -> Void) {

        var fileName: String = ""
        switch path {
        case "planetary/apod":
            fileName = "_mockApodResponse"
        default:
            completion(.failure("missin path for fetch"))
        }

        guard let data = LoadFileHelper.loadDataFromFile(with: fileName) else {
            completion(.failure("No data available for fetch"))
            return
        }

        completion(.success(data))
    }
}
