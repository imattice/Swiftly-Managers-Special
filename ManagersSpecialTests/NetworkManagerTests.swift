//
//  NetworkManagerTests.swift
//  ManagersSpecialTests
//
//  Created by Ike Mattice on 5/28/21.
//

import XCTest
@testable import ManagersSpecial

class NetworkManagerTests: XCTestCase {

    func testInitialization() {
        let expectation = expectation(description: "API Request Complete")
        let manager = NetworkManager()
        manager.fetch {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
        
        XCTAssertNotNil(manager.canvasUnit)
        XCTAssertFalse(manager.specials.isEmpty)
    }

}
