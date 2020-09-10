//
//  DetailCoordinator.swift
//  AstronomyPictures
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import UIKit

class DetailCoordinator: Coordinator {
    private let presenter: UINavigationController
    let picture: Picture

    init(picture: Picture, presenter: UINavigationController = UINavigationController()) {
        self.presenter = presenter
        self.picture = picture
    }

    func navigate() {
        let viewController = DetailViewController.fromStoryboard()
        viewController.coordinator = self
        viewController.viewModel = DetailViewModel(picture: picture)
        presenter.pushViewController(viewController, animated: true)
    }
}
