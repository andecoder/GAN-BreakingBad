//
//  DataProvider.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

public protocol DataProvider {
    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable
}

extension URLSession: DataProvider {

    public func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable {
        let task = dataTask(with: url) { data, _, error in
            if let data = data {
                completion(.success(data))
            }
            if let error = error {
                completion(.failure(error))
            }
        }
        task.resume()
        return task
    }
}
