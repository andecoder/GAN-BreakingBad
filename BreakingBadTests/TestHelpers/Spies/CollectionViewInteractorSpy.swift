//
//  CollectionViewInteractorSpy.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import BreakingBad

final class CollectionViewInteractorSpy: CollectionViewInteractor {

    private(set) var selectedIndex: Int?

    func selectItem(atIndex index: Int) {
        selectedIndex = index
    }
}
