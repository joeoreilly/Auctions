//
//  Dependancies.swift
//  Auctions
//
//  Created by Joe O'Reilly on 10/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import Foundation

struct Dependancies {

    var app = AppCoordinator()
    var auctions = AuctionsCoordinator()

    var network = Network()

}

let Current = Dependancies()
