//
//  PlaceholderViewController.swift
//  Auctions
//
//  Created by Joe O'Reilly on 11/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import UIKit

class ErrorViewController: UIViewController {

    struct ViewModel {
        var message: String
        var retry: String
        var retryAction: () -> ()
    }

    var viewModel: ViewModel? {
        didSet {
            message.text = viewModel?.message ?? ""
            button.setTitle(viewModel?.retry ?? "", for: .normal)
        }
    }

    fileprivate var message = UILabel()

    fileprivate var button = UIButton(type: .custom)

    override func loadView() {
        super.loadView()

        view.backgroundColor = .white

        message.font = UIFont.preferredFont(forTextStyle: .body)
        message.textColor = .lightGray
        message.numberOfLines = 0
        message.textAlignment = .center
        message.translatesAutoresizingMaskIntoConstraints = false

        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.setTitleColor(view.tintColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(message)
        view.addSubview(button)

        view.addConstraints([
            message.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            message.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            message.widthAnchor.constraint(lessThanOrEqualTo: view.readableContentGuide.widthAnchor),
            button.topAnchor.constraint(equalToSystemSpacingBelow: message.bottomAnchor, multiplier: 2),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }

    @objc func buttonTapped(_ sender: UIButton) {
        viewModel?.retryAction()
    }

}
