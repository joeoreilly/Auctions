//
//  PlaceholderViewController.swift
//  Auctions
//
//  Created by Joe O'Reilly on 11/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import UIKit

class PlaceholderViewController: UIViewController {

    struct ViewModel {
        var message: String
    }

    var viewModel: ViewModel? {
        didSet {
            message.text = viewModel?.message ?? ""
        }
    }

    fileprivate var message = UILabel()

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        message.font = UIFont.preferredFont(forTextStyle: .body)
        message.textColor = .lightGray
        message.translatesAutoresizingMaskIntoConstraints = false
        message.numberOfLines = 0
        message.textAlignment = .center

        view.addSubview(message)

        view.addConstraints([
            message.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            message.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            message.widthAnchor.constraint(lessThanOrEqualTo: view.readableContentGuide.widthAnchor)
            ])
    }

}
