//
//  DetailViewModelTests.swift
//  AstronomyPicturesTests
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import XCTest
@testable import AstronomyPictures

class DetailViewModelTests: XCTestCase {

    var viewModel: DetailViewModel!
    var picture: Picture!

    override func setUpWithError() throws {
        picture = LoadFileHelper.loadObjectFromFile(Picture.self, fileName: "_mockApodResponse")
        viewModel = DetailViewModel(picture: picture)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testInit() throws {
        XCTAssertTrue(viewModel.title == "GW190521: Unexpected Black Holes Collide")
    }
}
