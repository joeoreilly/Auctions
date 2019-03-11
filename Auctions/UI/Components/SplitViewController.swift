//
//  SplitViewController.swift
//  Auctions
//
//  Created by Joe O'Reilly on 11/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController {

    var master: UINavigationController

    init() {

        master = UINavigationController()

        super.init(nibName: nil, bundle: nil)

        viewControllers = [master, UIViewController()]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
