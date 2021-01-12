//
//  CharacterCollectionViewInteractorAdapterTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class CharacterCollectionViewInteractorAdapterTests: XCTestCase {

    func test_selectItem_forwardsMessageToInteractor() {
        let spyInteractor = CharacterSelectionInteractorSpy()
        let sut = CharacterCollectionViewInteractorAdapter(interactor: spyInteractor)
        sut.selectItem(atIndex: 3)
        XCTAssertEqual(spyInteractor.selectedIndex, 3)
    }

    // MARK: Helpers

    private final class CharacterSelectionInteractorSpy: CharacterSelectionInteractable {

        private(set) var selectedIndex: Int?

        func selectCharacter(atIndex index: Int) {
            selectedIndex = index
        }
    }
}
