//
//  CancellableSpy.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation
import BreakingBad

final class CancellableSpy: Cancellable {

    private(set) var cancelCalled: Bool = false

    func cancel() {
        cancelCalled = true
    }
}
