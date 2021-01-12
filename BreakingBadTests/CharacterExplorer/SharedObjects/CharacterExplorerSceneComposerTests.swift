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
        let spyRoutable = CharacterListRoutableSpy()
        guard let receivedVC = sut.makeCharacterListScene(router: spyRoutable) as? CharacterListViewController,
              receivedVC.interactor is CharacterListInteractor,
              receivedVC.searchController.searchResultsController is SearchResultViewController else {
            return XCTFail("Failed to get objects")
        }
    }

    func test_makeDetailsSceneForCharacter_usesCorrectComponents() {
        let character: Character = .testObject
        guard let receivedVC = sut.makeDetailScene(for: character) as? CharacterDetailViewController else {
            return XCTFail("Failed to get objects")
        }
        _ = receivedVC.view
        XCTAssertEqual(receivedVC.nameLabel.text, character.name)
    }

    // MARK: Helpers

    private let sut = CharacterExplorerSceneComposer(imageProvider: ImageProviderSpy(), remoteDataProvider: DataProviderSpy())

    private final class CharacterListRoutableSpy: CharacterListRoutable {

        func displayDetails(for character: Character) { }
    }
}
