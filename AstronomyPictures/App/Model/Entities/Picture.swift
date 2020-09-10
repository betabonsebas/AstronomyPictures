//
//  Picture.swift
//  AstronomyPictures
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import Foundation

struct Picture: Codable {
    let date: String
    let explanation: String
    let hdurl: String
    let title: String
    let url: String
}

extension Picture: Hashable {
    
}
