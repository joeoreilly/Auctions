//
//  Auction.swift
//  Auctions
//
//  Created by Joe O'Reilly on 10/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import Foundation

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

    static var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        return df
    }()

    static var currencyFormatter: NumberFormatter = {
        let cf = NumberFormatter()
        cf.positiveFormat = "¤#,##0.00"
        cf.locale = Locale(identifier: "en_GB")
        return cf
    }()

    func prettyCurencyString(_ number: NSNumber) -> String {
        let zeroDecimalPart = ".00"

        guard let string = Auction.currencyFormatter.string(from: number) else { return "" }
        if string.hasSuffix(zeroDecimalPart) {
            return String(string.dropLast(zeroDecimalPart.count))
        }

        return string
    }

    func closeString() -> String {
        return Auction.dateFormatter.string(from: close)
    }

    func amountString() -> String {
        return prettyCurencyString(NSNumber(value: Int32(cents/100)))
    }

    func details() -> String {
        return "Risk Band \(riskBand) • \(amountString()) • Closes \(closeString())"
    }

    func estimatedBadDebt() -> Double {
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
            return -1
        }
    }

    func estimatedReturnAmount(fee: Double = 0.01, bid: Double = 20.0) -> Double {

        let ebd = estimatedBadDebt()

        if ebd == -1 { return ebd }

        return (((1 + rate) - ebd - fee) * bid)

//        era = (1 + ar − ebd − f)xba
//          where:
//            ● era is the estimated return amount in GBP.
//            ● ar is the auction's rate.
//            ● ebd is the estimated bad debt associated to the auction's risk band (see table).
//            ● f is the fee, default is 0.01.
//            ● ba is the bid amount, default is £20.

    }

    func estimatedReturnAmountString() -> String {
        return prettyCurencyString(NSNumber(value: estimatedReturnAmount()))
    }

}
