//
//  SearchResultPresenterTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class SearchResultPresenterTests: XCTestCase {

    func test_show_updateDataProvider() {
        _ = makeSUT()
        XCTAssertEqual(spyDataProvider.receivedResults, [Character.testObject.name])
    }

    func test_searchCharacters_updatesDataProviderWithNewData() {
        let sut = makeSUT()
        sut.searchCharacters(withName: "blah")
        XCTAssertTrue(spyDataProvider.receivedResults.isEmpty)
        sut.searchCharacters(withName: "breaking")
        XCTAssertEqual(spyDataProvider.receivedResults, [Character.testObject.name])
    }

    func test_didSelectSearchResult_notifiesRouter() {
        let sut = makeSUT()
        sut.didSelectSearchResult(atIndex: 0)
        XCTAssertEqual(spyRouter.displayedCharacter, .testObject)
    }

    // MARK: Helpers

    let spyRouter = CharacterListRouterSpy()
    let spyDataProvider = SearchResultDataSourceSpy()

    private func makeSUT() -> SearchResultPresenter {
        let sut = SearchResultPresenter(router: spyRouter)
        sut.bind(to: spyDataProvider)
        sut.show([.testObject])
        return sut
    }
}
