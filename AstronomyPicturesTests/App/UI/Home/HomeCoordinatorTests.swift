//
//  HomeCoordinatorTests.swift
//  AstronomyPicturesTests
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import XCTest
@testable import AstronomyPictures

class HomeCoordinatorTests: XCTestCase {

    var window: UIWindow?
    var presenter: UINavigationController!

    override func setUpWithError() throws {
        window = UIWindow(frame: UIScreen.main.bounds)
        presenter = UINavigationController()
    }

    override func tearDownWithError() throws {
        window = nil
        presenter = nil
    }

    func testLaunchWorkFlow() throws {
        let coordinator = HomeCoordinator(window: window, presenter: presenter)
        coordinator.navigate()
        XCTAssert(presenter.topViewController is HomeViewController)
    }
}
