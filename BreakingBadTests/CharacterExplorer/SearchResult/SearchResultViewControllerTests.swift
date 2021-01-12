//
//  SearchResultViewControllerTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class SearchResultViewControllerTests: XCTestCase {

    func test_didSelectRowAtIndexPath_notifiesInteractor() {
        sut.tableView(UITableView(), didSelectRowAt: IndexPath(row: 3, section: 0))
        XCTAssertEqual(spyInteractor.selectedResultIndex, 3)
    }

    func test_updateSearchResults_notifiesDataSource() {
        _ = sut.view
        let expectedResult = ["A", "result"]
        sut.updateSearchResults(expectedResult)
        XCTAssertEqual(spyResultsDataSource.receivedResults, expectedResult)
    }

    // MARK: Helpers

    private let spyInteractor = SearchResultInteractorSpy()
    private let spyResultsDataSource = SearchResultDataSourceSpy()
    private lazy var sut = SearchResultViewController(interactor: spyInteractor, resultsDataSource: spyResultsDataSource)

    private final class SearchResultInteractorSpy: SearchResultInteractable {

        private(set) var selectedResultIndex: Int?

        func didSelectSearchResult(atIndex index: Int) {
            selectedResultIndex = index
        }
    }
}
