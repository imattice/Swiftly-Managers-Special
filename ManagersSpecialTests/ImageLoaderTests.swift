//
//  ImageLoaderTests.swift
//  ManagersSpecialTests
//
//  Created by Ike Mattice on 5/27/21.
//

import XCTest
@testable import ManagersSpecial

class ImageLoaderTests: XCTestCase {

    func testImageLoad() {
        let expectation = expectation(description: "Image Load Complete")
        let loader = ImageLoader(url: "https://raw.githubusercontent.com/Swiftly-Systems/code-exercise-ios/master/images/J.png")

        loader.loadImage() {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssertNotNil(loader.downloadedImage)
    }

}
