//
//  Auction.swift
//  Auctions
//
//  Created by Joe O'Reilly on 10/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import Foundation

struct AuctionResponse: Codable {
    var items: [Auction]
}

struct Auction: Codable {

    var id: Int
    var title: String
    var rate: Double
    var cents: Int
    var term: Int
    var riskBand: String
    var close: Date

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case rate
        case cents = "amount_cents"
        case term
        case riskBand = "risk_band"
        case close = "close_time"
    }
}

extension Auction {

    func estimatedBadDed() -> Double {
        switch riskBand {
        case "A+":
            return 0.01
        case "A":
            return 0.02
        case "B":
            return 0.03
        case "C":
            return 0.04
        case "C-":
            return 0.05
        default:
            assertionFailure("Unexpected risk band")
            return -1
        }
    }

    func estimatedReturnAmount(_ bid: Int) -> Double {

        return (((1 + rate) - estimatedBadDed() - 0.01) * 20.0)

//        era = (1 + ar − ebd − f)xba
//          where:
//            ● era is the estimated return amount in GBP.
//            ● ar is the auction's rate.
//            ● ebd is the estimated bad debt associated to the auction's risk band (see table).
//            ● f is the fee, default is 0.01.
//            ● ba is the bid amount, default is £20.

    }

}
