//
//  DataProviderSpy.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation
import BreakingBad

final class DataProviderSpy: DataProvider {

    private(set) var requestedURL: URL?
    var fetchDataReturns: [Result<Data, Error>] = []

    func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable {
        requestedURL = url
        fetchDataReturns.forEach { completion($0) }
        return CancellableSpy()
    }
}
