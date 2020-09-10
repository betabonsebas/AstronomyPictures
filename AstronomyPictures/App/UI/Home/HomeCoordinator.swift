//
//  HomeCoordinator.swift
//  AstronomyPictures
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import UIKit

class HomeCoordinator: Coordinator {
    private let presenter: UINavigationController

    init(window: UIWindow?, presenter: UINavigationController = UINavigationController()) {
        self.presenter = presenter
        window?.rootViewController = self.presenter
        window?.makeKeyAndVisible()
    }

    func navigate() {
        let viewController = HomeViewController.fromStoryboard()
        viewController.coordinator = self
        viewController.viewModel = HomeViewModel()
        presenter.pushViewController(viewController, animated: true)
    }

    func navigateDetail(with picture: Picture) {
        let coordinator = DetailCoordinator(picture: picture, presenter: presenter)
        coordinator.navigate()
    }
}
