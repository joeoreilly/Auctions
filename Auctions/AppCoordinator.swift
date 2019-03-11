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

    var splitView = SplitViewController()

    func start() {

        window.rootViewController = splitView
        window.makeKeyAndVisible()

        Current.auctions.start(in: splitView)
    }

}
