//
//  CharacterListPresenterTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class CharacterListPresenterTests: XCTestCase {

    func test_failedToLoadData_notifiesTheView() {
        let sut: CharacterListPresenter = makeSUT()
        sut.failedToLoadData()
        XCTAssertTrue(view.failedToLoadDataCalled)
    }

    func test_showCharacters_notifiesTheView() {
        let sut: CharacterListPresenter = makeSUT()
        sut.show([])
        XCTAssertTrue(view.dataReceivedCalled)
    }

    func test_showCharacters_notifiesChildPresenters() {
        let childPresenter = CharacterListChildPresenterSpy()
        let sut: CharacterListPresenter = makeSUT(childPresenters: [childPresenter])
        sut.show([.testObject])
        XCTAssertEqual(childPresenter.showedCharacters, [.testObject])
    }

    // MARK: Helpers

    private let view = CharacterListViewSpy()

    private func makeSUT(childPresenters: [CharacterListChildPresenter] = []) -> CharacterListPresenter {
        let sut = CharacterListPresenter(childPresenters: childPresenters)
        sut.bind(to: view)
        return sut
    }

    private final class CharacterListViewSpy: CharacterListViewable {
        private(set) var dataReceivedCalled: Bool = false
        private(set) var failedToLoadDataCalled: Bool = false

        func dataReceived() {
            dataReceivedCalled = true
        }

        func failedToLoadData() {
            failedToLoadDataCalled = true
        }
    }
}
