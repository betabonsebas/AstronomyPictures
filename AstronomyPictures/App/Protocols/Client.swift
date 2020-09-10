//
//  Client.swift
//  AstronomyPictures
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import Foundation

protocol Client {
    func fetch(path: String, queryItems: [URLQueryItem], completion: @escaping (Result<Data, Error>) -> Void)
}
