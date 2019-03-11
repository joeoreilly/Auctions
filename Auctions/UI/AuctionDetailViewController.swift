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
        var title: String
        var details: String
        var eraTitle = "Estimated Return Amount"
        var era: String
    }

    var viewModel: ViewModel? {
        didSet {
            titleLabel.text = viewModel?.title ?? ""
            detail.text = viewModel?.details ?? ""
            estimatedReturnAmountTitle.text = viewModel?.eraTitle ?? ""
            estimatedReturnAmount.text = viewModel?.era ?? ""
        }
    }

    fileprivate var stackView = UIStackView()

    fileprivate var titleLabel = UILabel()

    fileprivate var detail = UILabel()

    fileprivate var estimatedReturnAmountTitle = UILabel()

    fileprivate var estimatedReturnAmount = UILabel()

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        titleLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        titleLabel.numberOfLines = 0

        detail.font = UIFont.preferredFont(forTextStyle: .title2)
        detail.textColor = UIColor.lightGray
        detail.numberOfLines = 0

        estimatedReturnAmountTitle.font = UIFont.preferredFont(forTextStyle: .body)
        estimatedReturnAmountTitle.textColor = .darkGray
        estimatedReturnAmountTitle.numberOfLines = 0

        estimatedReturnAmount.font = UIFont.preferredFont(forTextStyle: .title2)

        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(detail)
        stackView.addArrangedSubview(estimatedReturnAmountTitle)
        stackView.addArrangedSubview(estimatedReturnAmount)

        stackView.setCustomSpacing(32, after: detail)

        view.addConstraints([
            stackView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            stackView.leadingAnchor.constraint(equalTo: view.readableContentGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.readableContentGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }

}
