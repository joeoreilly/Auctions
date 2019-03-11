//
//  Dependencies.swift
//  Auctions
//
//  Created by Joe O'Reilly on 10/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import Foundation

struct Dependencies {

    var app = AppCoordinator()
    var auctions = AuctionsCoordinator()

    var network: Networking = Network()
}

let Current = Dependencies()
