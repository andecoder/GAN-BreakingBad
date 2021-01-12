//
//  ImageProviderSpy.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit
import BreakingBad

final class ImageProviderSpy: ImageProvider {

    private let spyCancellable: CancellableSpy
    private(set) var fetchedImageURL: URL?
    var fetchImageReturns: Result<UIImage?, Error>?

    init(cancellable: CancellableSpy = CancellableSpy()) {
        self.spyCancellable = cancellable
    }

    func fetchImage(from url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable {
        fetchedImageURL = url
        if let result = fetchImageReturns {
            completion(result)
        }
        return spyCancellable
    }
}
