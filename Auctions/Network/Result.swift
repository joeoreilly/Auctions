//
//  Result.swift
//  Auctions
//
//  Created by Joe O'Reilly on 11/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
