//
//  CharacterExplorerSceneComposerTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class CharacterExplorerSceneComposerTests: XCTestCase {

    func test_makeCharacterListScene_usesCorrectComponents() {
        XCTAssertTrue(sut.makeCharacterListScene() is CharacterListViewController)
    }

    func test_makeDetailsSceneForCharacter_usesCorrectComponents() {
        XCTAssertTrue(sut.makeDetailScene(for: Character.testObject) is CharacterDetailViewController)
    }

    // MARK: Helpers

    private let sut = CharacterExplorerSceneComposer()
}
