//
//  StoryboardInstantiable.swift
//  AstronomyPictures
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable {
    static func fromStoryboard() -> Self
}

extension StoryboardInstantiable where Self: UIViewController {

    static func fromStoryboard() -> Self {
        guard let name = description().components(separatedBy: ".").last?
            .replacingOccurrences(of: "ViewController", with: "") else {
                return Self.init(nibName: nil, bundle: nil)
        }

        let storyboard = UIStoryboard(name: name, bundle: nil)
        
        return storyboard.instantiateInitialViewController() as! Self
    }
}
