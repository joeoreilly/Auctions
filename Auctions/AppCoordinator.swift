//
//  AppCoordinator.swift
//  Auctions
//
//  Created by Joe O'Reilly on 10/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import UIKit

struct AppCoordinator {

    var window = UIWindow(frame: UIScreen.main.bounds)

    var navigation = UINavigationController()

    func start() {

        let loading = LoadingViewController()
        loading.viewModel = LoadingViewController.ViewModel(message: "Loading Auctions")

        navigation.viewControllers = [loading]

        window.rootViewController = navigation
        window.makeKeyAndVisible()

        Current.auctions.start(in: navigation)
    }

}

class AuctionsCoordinator {

    var navigation: UINavigationController?

    func start(in navigationController: UINavigationController) {

        navigation = navigationController

        let url = URL(string: "http://localhost:8080/auctions.json")!
//        let url = URL(string: "https://fc-ios-test.herokuapp.com/auctions")!

        Current.network.data(from: url) { result in

            switch result {
            case let .success(data):
                self.injestAuctions(data: data)
            case let .failure(error):
                print("Error \(error)")
            }

        }

    }

    func injestAuctions(data: Data) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)

        do {

            let response = try decoder.decode(AuctionResponse.self, from: data)

            let auctions = response.items

            showAuctions(auctions)
        }
        catch {
            print("Fucking \(error)")
        }

    }

    func showAuctions(_ auctions: [Auction]) {

        let auctionsViewController = AuctionsViewController(auctions: auctions)
        auctionsViewController.didSelect = { self.showAuction($0) }

        navigation?.setViewControllers([auctionsViewController], animated: true)

    }

    func showAuction(_ auction: Auction) {

        let auctionDetailViewController = AuctionDetailViewController()
        auctionDetailViewController.viewModel = AuctionDetailViewController.ViewModel(estimatedReturnAmount: "£\(auction.estimatedReturnAmount(0))")

        navigation?.pushViewController(auctionDetailViewController, animated: true)

    }

}
