//
//  FilterCollectionViewInteractorAdapterTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class FilterCollectionViewInteractorAdapterTests: XCTestCase {

    func test_selectItem_forwardsMessageToInteractor() {
        let spyInteractor = FilterSelectionInteractorSpy()
        let sut = FilterCollectionViewInteractorAdapter(interactor: spyInteractor)
        sut.selectItem(atIndex: 5)
        XCTAssertEqual(spyInteractor.toggleIndex, 5)
    }

    // MARK: Helpers

    private final class FilterSelectionInteractorSpy: FilterSelectionInteractable {

        private(set) var toggleIndex: Int?

        func toggleFilter(atIndex index: Int) {
            toggleIndex = index
        }
    }
}
