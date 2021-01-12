//
//  CharacterListInteractorTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class CharacterListInteractorTests: XCTestCase {

    func test_loadCharacters_requestWorkerForData() {
        sut.loadCharacters()
        XCTAssertTrue(spyWorker.loadCharactersCalled)
    }

    func test_loadCharacters_notifyPresenterOfFailures() {
        spyWorker.loadCharactersReturn = .failure(URLError(.badServerResponse))
        sut.loadCharacters()
        XCTAssertTrue(spyPresenter.failedToLoadDataCalled)
    }

    func test_loadCharacters_forwardsReceivedCharactersToPresent() {
        let expectedResult = [Character.testObject]
        spyWorker.loadCharactersReturn = .success(expectedResult)
        sut.loadCharacters()
        XCTAssertEqual(spyPresenter.showedCharacters, expectedResult)
    }

    // MARK: Helpers

    private let spyPresenter = CharacterListPresenterSpy()
    private let spySearchInteractor = SearchInteractorSpy()
    private let spyWorker = CharacterListWorkerSpy()
    private lazy var sut = CharacterListInteractor(presenter: spyPresenter, searchInteractor: spySearchInteractor, worker: spyWorker)

    private final class CharacterListPresenterSpy: CharacterListPresentable {

        private(set) var failedToLoadDataCalled: Bool = false
        private(set) var showedCharacters: [Character] = []

        func failedToLoadData() {
            failedToLoadDataCalled = true
        }

        func show(_ characters: [Character]) {
            showedCharacters = characters
        }
    }

    private final class CharacterListWorkerSpy: CharacterListWorkable {

        var loadCharactersReturn: Result<[Character], Error>?
        private(set) var loadCharactersCalled: Bool = false

        func loadCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
            loadCharactersCalled = true
            if let result = loadCharactersReturn {
                completion(result)
            }
        }
    }
}
