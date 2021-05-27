//
//  SpecialTests.swift
//  ManagersSpecialTests
//
//  Created by Ike Mattice on 5/27/21.
//

import XCTest
@testable import ManagersSpecial

class SpecialTests: XCTestCase {

    func testFetchAll() {
        let expectation = expectation(description: "API Request Complete")
        var managerSpecial: ManagerSpecial?
       
        ManagerSpecial.fetchFromAPI() { special in
            managerSpecial = special
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssertNotNil(managerSpecial)
    }
}
