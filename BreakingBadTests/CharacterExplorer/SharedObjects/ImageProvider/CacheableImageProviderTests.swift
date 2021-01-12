//
//  CacheableImageProviderTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class CacheableImageProviderTests: XCTestCase {

    func test_fetchImageFromURL_hashesURL() {
        _ = sut.fetchImage(from: testURL) { _ in }
        XCTAssertEqual(spyHasher.hashedString, "www.yahoo.com")
    }

    func test_fetchImageFromURL_returnsLocalImageWhenAvailable() {
        spyLocalImageProvider.fileUrlReturns = testImageURL
        let expectation = XCTestExpectation()
        _ = sut.fetchImage(from: testURL) { result in
            guard case .success = result else {
                return XCTFail("Failed to receive image")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(spyLocalImageProvider.fileUrlArg, "www.yahoo.com")
        XCTAssertNil(spyRemoteImageProvider.fetchedImageURL)
    }

    func test_fetchImageFromURL_requestsRemoteImageWhenLocalIsNotAvailable() {
        _ = sut.fetchImage(from: testURL) { _ in }
        XCTAssertEqual(spyRemoteImageProvider.fetchedImageURL, testURL)
    }

    func test_fetchImageFromURL_savesRemoteImagesReceivedAndForwardsResult() {
        let image: UIImage? = UIImage(named: "placeholder")
        spyRemoteImageProvider.fetchImageReturns = .success(image)
        let expectation = XCTestExpectation()
        _ = sut.fetchImage(from: testURL) { result in
            guard case let .success(resultImage) = result else {
                return XCTFail("Failed to get image")
            }
            XCTAssertEqual(resultImage, image)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(spyLocalImageProvider.savedImage, image)
        XCTAssertEqual(spyLocalImageProvider.savedName, "www.yahoo.com")
    }

    // MARK: Helpers

    private let testURL = URL(string: "www.yahoo.com")!
    private let testImageURL: URL = {
        let bundle = Bundle(for: URLSessionDataProviderTests.self)
        return bundle.url(forResource: "cached", withExtension: "png")!
    }()
    private let spyHasher = HashGeneratorSpy()
    private let spyLocalImageProvider = CacheFileProviderSpy()
    private let spyRemoteImageProvider = ImageProviderSpy()
    private lazy var sut = CacheableImageProvider(hasher: spyHasher, localImageProvider: spyLocalImageProvider, remoteImageProvider: spyRemoteImageProvider)

    private final class HashGeneratorSpy: HashGenerator {

        private(set) var hashedString: String?

        func hash(_ string: String) -> String {
            hashedString = string
            return string
        }
    }

    private final class CacheFileProviderSpy: CacheFileProvider {

        private(set) var fileUrlArg: String?
        var fileUrlReturns: URL?
        private(set) var savedImage: UIImage?
        private(set) var savedName: String?

        func fileUrl(forName name: String) -> URL? {
            fileUrlArg = name
            return fileUrlReturns
        }

        func save(_ image: UIImage, withName name: String) {
            savedImage = image
            savedName = name
        }
    }
}
