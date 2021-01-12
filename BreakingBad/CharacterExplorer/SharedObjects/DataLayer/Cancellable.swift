//
//  Cancellable.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

public protocol Cancellable {
    func cancel()
}

extension URLSessionDataTask: Cancellable { }
