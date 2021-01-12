//
//  RemoteImageProviderTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class RemoteImageProviderTests: XCTestCase {

    func test_fetchImageFromURL_sendsCorrectURLtoRequester() {
        _ = sut.fetchImage(from: testURL) { _ in }
        XCTAssertEqual(spyProvider.requestedURL, testURL)
    }

    func test_fetchImageFromURL_forwardsErrorsFromRequester() {
        let fileError = URLError(.cannotCreateFile)
        spyProvider.fetchDataReturns = [.failure(fileError)]
        let expectation = XCTestExpectation()
        _ = sut.fetchImage(from: testURL) { result in
            guard case let .failure(error) = result, let returnedError = error as? URLError else {
                return XCTFail("Failed to get error")
            }
            XCTAssertEqual(returnedError, fileError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_fetchImageFromURL_returnsImageRepresentationOfDataReceived() {
        spyProvider.fetchDataReturns = [.success(Data())]
        let expectation = XCTestExpectation()
        _ = sut.fetchImage(from: testURL) { result in
            guard case let .success(image) = result else {
                return XCTFail("Failed to get image")
            }
            XCTAssertNil(image)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    // MARK: Helpers

    private let testURL: URL = URL(string: "www.google.com")!
    private let spyProvider = DataProviderSpy()
    private lazy var sut = RemoteImageProvider(requester: spyProvider)
}
