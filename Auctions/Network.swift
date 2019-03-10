//
//  Network.swift
//  Auctions
//
//  Created by Joe O'Reilly on 10/03/2019.
//  Copyright © 2019 Joe O'Reilly. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

protocol Networking {
    func data(from url: URL, completion: @escaping (Result<Data>) -> ())
}

class Network: Networking {

    enum NetworkError: Error {
        case noData
    }

    func data(from url: URL, completion: @escaping (Result<Data>) -> ()) {

        URLSession.shared.dataTask(with: url) { (data, _, dataTaskError) in

            DispatchQueue.main.async {

                if let dataTaskError = dataTaskError {
                    completion(.failure(dataTaskError))
                    return
                }

                guard let data = data else {
                    completion(.failure(NetworkError.noData))
                    return
                }

                completion(.success(data))
            }

            }.resume()
    }

}
