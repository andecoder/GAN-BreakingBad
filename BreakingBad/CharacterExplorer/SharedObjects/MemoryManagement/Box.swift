//
//  Box.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

final class Box<T> {

    private(set) var element: T?

    init(_ element: T) {
        self.element = element
    }
}
