//
//  AuctionsViewController.swift
//  Auctions
//
//  Created by Joe O'Reilly on 10/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import UIKit

class AuctionsViewController: UITableViewController {

    var auctions = [Auction]()

    var didSelect: ((Auction) -> ())?

    init(auctions: [Auction]) {

        self.auctions = auctions

        super.init(nibName: nil, bundle: nil)

        title = "Auctions"

        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(AuctionTableViewCell.self, forCellReuseIdentifier: AuctionTableViewCell.reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return auctions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: AuctionTableViewCell.reuseIdentifier, for: indexPath)

        if let auctionCell = cell as? AuctionTableViewCell {
            auctionCell.viewModel = AuctionTableViewCell.ViewModel(auction: auctions[indexPath.row])
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelect?(auctions[indexPath.row])
    }

}

class AuctionTableViewCell: UITableViewCell {

    struct ViewModel {
        var name: String
        var details: String
    }

    static var reuseIdentifier: String {
        return String(describing: self)
    }

    var viewModel: ViewModel? {
        didSet {
            name.text = viewModel?.name ?? ""
            details.text = viewModel?.details ?? ""
        }
    }

    fileprivate var name: UILabel
    fileprivate var details: UILabel

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        name = UILabel()
        name.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        name.translatesAutoresizingMaskIntoConstraints = false

        details = UILabel()
        details.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        details.textColor = .darkGray
        details.translatesAutoresizingMaskIntoConstraints = false

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        accessoryType = .disclosureIndicator

        preservesSuperviewLayoutMargins = true
        contentView.preservesSuperviewLayoutMargins = true

        contentView.addSubview(name)
        contentView.addSubview(details)

        contentView.addConstraints([
            name.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            name.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),

            contentView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: name.trailingAnchor),

            details.topAnchor.constraint(equalToSystemSpacingBelow: name.bottomAnchor, multiplier: 1),
            details.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),

            contentView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: details.trailingAnchor),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: details.bottomAnchor)
            ])
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

extension AuctionTableViewCell.ViewModel {

    init(auction: Auction) {
        name = auction.title

        let df = DateFormatter()
        df.dateStyle = .short

        details = "Closes \(df.string(from: auction.close)) • \(auction.riskBand)"
    }

}
