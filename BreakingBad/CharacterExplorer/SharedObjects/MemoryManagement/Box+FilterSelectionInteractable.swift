//
//  Box+FilterSelectionInteractable.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

extension Box: FilterSelectionInteractable where T: FilterSelectionInteractable {

    func toggleFilter(atIndex index: Int) {
        element?.toggleFilter(atIndex: index)
    }
}
