//
//  LoadingViewController.swift
//  Auctions
//
//  Created by Joe O'Reilly on 10/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {

    struct ViewModel {
        var message: String
    }

    var viewModel: ViewModel? {
        didSet {
            message.text = viewModel?.message ?? ""
        }
    }

    fileprivate var indicator = UIActivityIndicatorView(style: .gray)

    fileprivate var message = UILabel()

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false

        message.textColor = .lightGray
        message.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(indicator)
        view.addSubview(message)

        view.addConstraints([
            message.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            message.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicator.topAnchor.constraint(equalToSystemSpacingBelow: message.bottomAnchor, multiplier: 2),
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        indicator.startAnimating()
    }
}
