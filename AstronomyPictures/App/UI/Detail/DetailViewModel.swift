//
//  DetailViewModel.swift
//  AstronomyPictures
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import Foundation

class DetailViewModel: ViewModel {
    var title: String
    var picture: Picture

    init(picture: Picture) {
        self.title = picture.title
        self.picture = picture
    }
}
