//
//  ImageProvider.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

public protocol ImageProvider {
    func fetchImage(from url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable
}

final class RemoteImageProvider: ImageProvider {

    private let requester: DataProvider

    init(requester: DataProvider) {
        self.requester = requester
    }

    func fetchImage(from url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable {
        requester.fetchData(from: url) { result in
            switch result {
            case let .success(data):
                let image = UIImage(data: data)
                completion(.success(image))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
