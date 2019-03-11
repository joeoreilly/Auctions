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
