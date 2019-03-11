//
//  AuctionsTests.swift
//  AuctionsTests
//
//  Created by Joe O'Reilly on 10/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import XCTest
@testable import Auctions

class AuctionsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNormalEstimatedReturnAmount() {

        let aPlusAuction = Auction(id: 0, title: "Test", rate: 0.05, cents: 47000000, term: 0, riskBand: "A+", close: Date())
        XCTAssertEqual(aPlusAuction.estimatedReturnAmount(bid: 10), 10.3)

        let bAuction = Auction(id: 1, title: "Test", rate: 0.06, cents: 5000000, term: 0, riskBand: "B", close: Date())
        XCTAssertEqual(bAuction.estimatedReturnAmount(bid: 15), 15.3)
    }

    func testEstimatedReturnAmountWithMissingRiskBand() {

        let auction = Auction(id: 0, title: "Test", rate: 0.05, cents: 47000000, term: 0, riskBand: "", close: Date())
        XCTAssertEqual(auction.estimatedReturnAmount(), -1.0)
    }

}
