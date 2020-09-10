//
//  Service.swift
//  AstronomyPictures
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import Foundation

protocol Service {
    var client: Client { get }
    func fetch<T: Decodable>(for date: String, completion: @escaping (Result<T, Error>) -> Void)
}
