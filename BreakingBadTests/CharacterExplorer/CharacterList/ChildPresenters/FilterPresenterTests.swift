//
//  FilterPresenterTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class FilterPresenterTests: XCTestCase {

    func test_show_updatesFilterDataProvider() {
        _ = makeSUT()
        let expectedVMs = [1, 2, 3, 4, 5].map {
            FilterCellViewModel(id: $0, name: "S0\($0)", isSelected: false)
        }
        XCTAssertEqual(spyDataProvider.receivedViewModels, expectedVMs)
    }

    func test_show_updatesDetailsPresenter() {
        _ = makeSUT()
        XCTAssertEqual(detailsPresenter.showedCharacters, characters)
    }

    func test_toggleFilter_updatesFilterDataProvider() {
        let sut = makeSUT()
        sut.toggleFilter(atIndex: 1)
        let expectedVMs = [1, 2, 3, 4, 5].map {
            FilterCellViewModel(id: $0, name: "S0\($0)", isSelected: $0 == 2)
        }
        XCTAssertEqual(spyDataProvider.receivedViewModels, expectedVMs)
    }

    func test_toggleFilter_updatesDetailsPresenter() {
        let sut = makeSUT()
        sut.toggleFilter(atIndex: 1)
        XCTAssertEqual(detailsPresenter.showedCharacters, characters.dropLast())
        sut.toggleFilter(atIndex: 1)
        XCTAssertEqual(detailsPresenter.showedCharacters, characters)
    }

    // MARK: Helpers

    private let characters: [Character] = [
        Character(id: 1, name: "Something", occupation: ["A thing"], imageUrl: URL(string: "www.some.com")!, status: "Alive", nickName: "Some", appearance: [1, 2, 3, 4]),
        Character(id: 2, name: "Nothing", occupation: ["Stuff"], imageUrl: URL(string: "www.any.com")!, status: "Unknown", nickName: "Nope", appearance: [4, 5])
    ]
    private let detailsPresenter = CharacterListChildPresenterSpy()
    private let spyDataProvider = CollectionViewCellProviderSpy(interactor: CollectionViewInteractorSpy())

    private func makeSUT() -> FilterPresenter {
        let sut = FilterPresenter(detailsPresenter: detailsPresenter)
        sut.bind(to: spyDataProvider)
        sut.show(characters)
        return sut
    }

    private final class CollectionViewCellProviderSpy: CollectionViewCellProvider<FilterCollectionViewCell, FilterCellViewModel> {

        private(set) var receivedViewModels: [FilterCellViewModel] = []

        override func updateViewModels(_ viewModels: [FilterCellViewModel]) {
            receivedViewModels = viewModels
            super.updateViewModels(viewModels)
        }
    }
}

extension FilterCellViewModel: Equatable {

    public static func ==(lhs: FilterCellViewModel, rhs: FilterCellViewModel) -> Bool {
        return lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.isSelected == rhs.isSelected
    }
}
