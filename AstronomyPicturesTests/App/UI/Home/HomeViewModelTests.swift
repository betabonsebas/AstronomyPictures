//
//  HomeViewModelTests.swift
//  AstronomyPicturesTests
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import XCTest
@testable import AstronomyPictures

class HomeViewModelTests: XCTestCase {

    var viewModel: HomeViewModel!

    override func setUpWithError() throws {
        viewModel = HomeViewModel(service: PictureService(client: MockNetworkClient()))
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testExample() throws {
        XCTAssertTrue(viewModel.title == "Home")
    }

    func testFetchPictures() throws {
        let expectation = XCTestExpectation(description: "success request")

        viewModel.fetchPictures { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(success)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("test fail with error: \(error.localizedDescription)")
            }
        }

        wait(for: [expectation], timeout: 0.5)
    }
}
