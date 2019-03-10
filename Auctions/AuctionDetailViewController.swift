//
//  AuctionDetailViewController.swift
//  Auctions
//
//  Created by Joe O'Reilly on 10/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import UIKit

class AuctionDetailViewController: UIViewController {

    struct ViewModel {
        var estimatedReturnAmount: String
    }

    var viewModel: ViewModel? {
        didSet {
            estimatedReturnAmountLabel.text = viewModel?.estimatedReturnAmount ?? ""
        }
    }

    fileprivate var estimatedReturnAmountLabel = UILabel()

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        estimatedReturnAmountLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(estimatedReturnAmountLabel)

        view.addConstraints([
            estimatedReturnAmountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            estimatedReturnAmountLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }

}
