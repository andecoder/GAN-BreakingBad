//
//  CharacterPresenterTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class CharacterPresenterTests: XCTestCase {

    func test_show_updatesDataProvider() {
        _ = makeSUT()
        let expectedNames = characters.map { $0.name }
        XCTAssertEqual(spyDataProvider.receivedViewModels.map { $0.name }, expectedNames)
    }

    func test_loadImage_usesImageProvider() {
        _ = makeSUT()
        _ = spyDataProvider.receivedViewModels.last?.loadImage { _ in }
        XCTAssertEqual(spyImageProvider.fetchedImageURL, characters.last?.imageUrl)
    }

    func test_selectCharacterAtIndex_forwardsTheMessageToRouter() {
        let sut = makeSUT()
        sut.selectCharacter(atIndex: 2)
        XCTAssertEqual(spyRouter.displayedCharacter, .testObject)
    }

    // MARK: Helpers

    private let spyRouter = CharacterListRouterSpy()
    private let spyImageProvider = ImageProviderSpy()
    private let spyDataProvider = CollectionViewCellProviderSpy(interactor: CollectionViewInteractorSpy())

    private let characters: [Character] = [
        Character(id: 1, name: "Something", occupation: ["A thing"], imageUrl: URL(string: "www.some.com")!, status: "Alive", nickName: "Some", appearance: [1, 2, 3, 4]),
        Character(id: 2, name: "Nothing", occupation: ["Stuff"], imageUrl: URL(string: "www.any.com")!, status: "Unknown", nickName: "Nope", appearance: [4, 5]),
        .testObject
    ]

    private func makeSUT() -> CharacterPresenter {
        let sut = CharacterPresenter(imageProvider: spyImageProvider, router: spyRouter)
        sut.bind(to: spyDataProvider)
        sut.show(characters)
        return sut
    }

    private final class CharacterListRouterSpy: CharacterListRoutable {

        private(set) var displayedCharacter: Character?

        func displayDetails(for character: Character) {
            displayedCharacter = character
        }
    }

    private final class CollectionViewCellProviderSpy: CollectionViewCellProvider<CharacterCollectionViewCell, CharacterCellViewModel> {

        private(set) var receivedViewModels: [CharacterCellViewModel] = []

        override func updateViewModels(_ viewModels: [CharacterCellViewModel]) {
            receivedViewModels = viewModels
            super.updateViewModels(viewModels)
        }
    }
}
