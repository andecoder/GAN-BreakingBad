//
//  CacheableImageProvider.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

protocol HashGenerator {
    func hash(_: String) -> String
}

final class CacheableImageProvider: ImageProvider {

    private let hasher: HashGenerator
    private let localImageProvider: CacheFileProvider
    private let remoteImageProvider: ImageProvider

    init(hasher: HashGenerator, localImageProvider: CacheFileProvider, remoteImageProvider: ImageProvider) {
        self.hasher = hasher
        self.localImageProvider = localImageProvider
        self.remoteImageProvider = remoteImageProvider
    }

    func fetchImage(from url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable {
        let fileName: String = hasher.hash(url.absoluteString)
        if let fileUrl: URL = localImageProvider.fileUrl(forName: fileName),
              let imageData: Data = try? Data(contentsOf: fileUrl),
              let image = UIImage(data: imageData) {
            completion(.success(image))
            return FakeCancellable()
        } else {
            return remoteImageProvider.fetchImage(from: url) { [localImageProvider] result in
                if case let .success(resultImage) = result, let image = resultImage {
                    localImageProvider.save(image, withName: fileName)
                }
                completion(result)
            }
        }
    }

    private final class FakeCancellable: Cancellable {

        func cancel() { }
    }
}
