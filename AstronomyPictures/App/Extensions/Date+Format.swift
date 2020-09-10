//
//  Date+Format.swift
//  AstronomyPictures
//
//  Created by Sebastian Bonilla Betancur on 10/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import Foundation

extension Date {

    func dashedYYYYMMddString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
