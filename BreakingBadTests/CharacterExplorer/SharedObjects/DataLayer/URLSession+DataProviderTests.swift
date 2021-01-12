//
//  URLSession+DataProviderTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class URLSessionDataProviderTests: XCTestCase, URLSessionDelegate {

    func test_fetchData_returnsDataForSuccessRequests() {
        let bundle = Bundle(for: URLSessionDataProviderTests.self)
        let testURL: URL = bundle.url(forResource: "URLSessionTest", withExtension: "txt")!
        let expectation = XCTestExpectation()
        let session = URLSession(configuration: .default, delegate: URLSessionTestDelegate(), delegateQueue: nil)
        _ = session.fetchData(from: testURL) { result in
            let data = try! result.get()
            let resultText = String(data: data, encoding: .utf8)
            XCTAssertEqual(resultText, "Your test did succeed!!!\n")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_fetchData_returnsErrorForFailedRequests() {
        let testURL = URL(string: "www.iDontExist.what")!
        let expectation = XCTestExpectation()
        let session = URLSession(configuration: .default, delegate: URLSessionTestDelegate(), delegateQueue: nil)
        _ = session.fetchData(from: testURL, completion: { result in
            guard case .failure = result else {
                return XCTFail("Did not receive an error")
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.1)
    }

    // MARK: Helpers

    private final class URLSessionTestDelegate: NSObject, URLSessionDataDelegate {

        typealias TaskCompletion = (Result<Data, Error>) -> Void
        typealias PendingRequest = [(task: URLSessionDataTask, completion: TaskCompletion)]

        private var pendingRequests: PendingRequest = []

        func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
            guard let taskIndex = firstIndex(of: task) else {
                return
            }
            let completion = pendingRequests[taskIndex].completion
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(Data()))
            }
            pendingRequests.remove(at: taskIndex)
        }

        func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
            guard let taskIndex = firstIndex(of: dataTask) else {
                return
            }
            let completion = pendingRequests[taskIndex].completion
            completion(.success(data))
            pendingRequests.remove(at: taskIndex)
        }

        private func firstIndex(of task: URLSessionTask) -> PendingRequest.Index? {
            return pendingRequests.firstIndex { $0.task == task }
        }
    }
}
