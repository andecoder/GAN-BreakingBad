//
//  CharacterListViewControllerTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class CharacterListViewControllerTests: XCTestCase {

    func test_whenViewLoads_bindsViewsToDataProviders() {
        _ = sut.view
        XCTAssertEqual(spyFilterProvider.boundView, sut.filterCollectionView)
        XCTAssertEqual(spyCharacterProvider.boundView, sut.charactersCollectionView)
    }

    func test_whenViewLoads_asksInteractorForData() {
        _ = sut.view
        XCTAssertTrue(spyInteractor.loadCharactersCalled)
    }

    func test_updateSearchResults_sendsSearchedTermToInteractor() {
        let searchController = UISearchController()
        let searchedText: String = "Some text"
        searchController.searchBar.text = searchedText
        sut.updateSearchResults(for: searchController)
        XCTAssertEqual(spyInteractor.searchedCharacterName, searchedText)
    }

    func test_updateSearchResults_doesNotSendEmptyStrings() {
        sut.updateSearchResults(for: UISearchController())
        XCTAssertNil(spyInteractor.searchedCharacterName)
    }

    func test_dataReceived_showsFilterLabell() {
        _ = sut.view
        let promise = XCTKVOExpectation(keyPath: "isHidden", object: sut.filterLabel!)
        sut.dataReceived()
        _ = XCTWaiter().wait(for: [promise], timeout: 1)
        XCTAssertFalse(sut.filterLabel.isHidden)
    }

    // MARK: Helpers

    private let spyInteractor = CharacterListInteractorSpy()
    private lazy var spyCharacterProvider = CollectionViewDataProviderSpy()
    private lazy var spyFilterProvider = CollectionViewDataProviderSpy()
    private lazy var sut = CharacterListViewController(characterDataProvider: spyCharacterProvider, filterDataProvider: spyFilterProvider, interactor: spyInteractor, resultsController: UIViewController())

    private final class CharacterListInteractorSpy: CharacterListInteractable {

        private(set) var loadCharactersCalled: Bool = false
        private(set) var searchedCharacterName: String?

        func loadCharacters() {
            loadCharactersCalled = true
        }

        func searchCharacters(withName name: String) {
            searchedCharacterName = name
        }
    }

    private final class CollectionViewDataProviderSpy: CollectionViewDataProvider {

        private(set) var boundView: UICollectionView?

        func bind(to view: UICollectionView) {
            boundView = view
        }
    }
}
