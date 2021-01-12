//
//  Box+SearchResultInteractable.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

extension Box: SearchResultInteractable where T: SearchResultInteractable {

    func didSelectSearchResult(atIndex index: Int) {
        element?.didSelectSearchResult(atIndex: index)
    }
}
