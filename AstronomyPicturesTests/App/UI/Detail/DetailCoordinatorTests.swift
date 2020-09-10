//
//  DetailCoordinatorTests.swift
//  AstronomyPicturesTests
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import XCTest
@testable import AstronomyPictures

class DetailCoordinatorTests: XCTestCase {

    var presenter: UINavigationController!
    var picture: Picture!

    override func setUpWithError() throws {
        presenter = UINavigationController()
        picture = LoadFileHelper.loadObjectFromFile(Picture.self, fileName: "_mockApodResponse")
    }

    override func tearDownWithError() throws {
        presenter = nil
    }

    func testLaunchWorkFlow() throws {
        let coordinator = DetailCoordinator(picture: picture, presenter: presenter)
        coordinator.navigate()
        XCTAssert(presenter.topViewController is DetailViewController)
    }
}
