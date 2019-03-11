//
//  Network.swift
//  Auctions
//
//  Created by Joe O'Reilly on 10/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import Foundation

protocol Networking {
    func data(from url: URL, completion: @escaping (Result<Data>) -> ())
}
