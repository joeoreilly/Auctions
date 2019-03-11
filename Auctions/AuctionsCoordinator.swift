//
//  AuctionsCoordinator.swift
//  Auctions
//
//  Created by Joe O'Reilly on 11/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import UIKit

class AuctionsCoordinator {

    var splitView: SplitViewController!

    func start(in splitView: SplitViewController) {

        self.splitView = splitView
        showPlaceholderIfNeeded()

        loadAuctions()
    }

    func loadAuctions(after delay: Int = 0) {

        showLoading("Loading Auctions...")

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.seconds(delay)) {

            let url = URL(string: "https://fc-ios-test.herokuapp.com/auctions")!
//            let url = URL(string: "http://localhost:8080/auctions.json")!
//            let url = URL(string: "http://localhost:8080/foo")!

            Current.network.data(from: url) { result in

                switch result {
                case let .success(data):
                    self.injestAuctions(data: data)
                case let .failure(error):
                    self.showError(error) {
                        self.loadAuctions(after: 1)
                    }
                }
            }

        }

    }

    fileprivate lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }()

    func injestAuctions(data: Data) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        do {

            let response = try decoder.decode(AuctionResponse.self, from: data)

            let auctions = response.items

            showAuctions(auctions)
        }
        catch {
            showError(error) {
                self.loadAuctions(after: 1)
            }
        }

    }

    func showLoading(_ message: String) {
        let loadingViewController = LoadingViewController()
        loadingViewController.viewModel = LoadingViewController.ViewModel(message: message)

        splitView.master.viewControllers = [loadingViewController]
    }

    func showError(_ error: Error, retry: @escaping () -> ()) {

        let errorViewController = ErrorViewController()
        errorViewController.viewModel = ErrorViewController.ViewModel(message: error.localizedDescription,
                                                                      retry: "Try Again",
                                                                      retryAction: retry)

        splitView.master.viewControllers = [errorViewController]
    }

    func showAuctions(_ auctions: [Auction]) {
        let auctionsViewController = AuctionsViewController(auctions: auctions)
        auctionsViewController.didSelect = { self.showAuction($0) }

        splitView?.master.viewControllers = [auctionsViewController]
    }

    func showAuction(_ auction: Auction) {
        let auctionDetailViewController = AuctionDetailViewController()
        let viewModel = AuctionDetailViewController.ViewModel(title: auction.title,
                                                              details: auction.details(),
                                                              eraTitle: "Estimated Return Amount (£20 Investment)",
                                                              era: auction.estimatedReturnAmountString())

        auctionDetailViewController.viewModel = viewModel

        showInDetailViewController(auctionDetailViewController)
    }

    func showPlaceholderIfNeeded() {
        guard (splitView.viewControllers.count == 2) else { return }

        let placeholderViewController = PlaceholderViewController()
        placeholderViewController.viewModel = PlaceholderViewController.ViewModel(message: "Select an Auction to see its details")

        showInDetailViewController(placeholderViewController)
    }

    func showInDetailViewController(_ viewController: UIViewController) {
        viewController.navigationItem.leftBarButtonItem = splitView?.displayModeButtonItem
        viewController.navigationItem.leftItemsSupplementBackButton = true

        let navigation = UINavigationController(rootViewController: viewController)


        if splitView?.viewControllers.count == 2 {
            splitView?.viewControllers[1] = navigation
        }
        else {
            splitView.showDetailViewController(viewController, sender: self)
        }
    }
}
