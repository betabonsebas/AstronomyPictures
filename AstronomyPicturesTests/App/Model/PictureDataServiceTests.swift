//
//  PictureDataServiceTests.swift
//  AstronomyPicturesTests
//
//  Created by Sebastian Bonilla Betancur on 9/09/20.
//  Copyright © 2020 Sebastian Bonilla Betancur. All rights reserved.
//

import XCTest
@testable import AstronomyPictures

class PictureDataServiceTests: XCTestCase {

    var service: PictureService!

    override func setUpWithError() throws {
        service = PictureService(client: MockNetworkClient())
    }

    override func tearDownWithError() throws {
        service = nil
    }

    func testFetch() throws {
        let expectation = XCTestExpectation(description: "success request")

        service.fetch(for: "2020-09-09") { (result: Result<Picture, Error>) in
            switch result {
            case .success(let picture):
                XCTAssertNotNil(picture)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("test fail with error: \(error.localizedDescription)")
            }
        }

        wait(for: [expectation], timeout: 0.5)
    }
}
