//
//  SearchResultDataSourceTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class SearchResultDataSourceTests: XCTestCase {

    func test_init_numberOfRowsInSectionReturnsZero() {
        XCTAssertEqual(sut.tableView(tableView, numberOfRowsInSection: 0), 0)
    }

    func test_updateSearchResults_numberOfRowsInSectionReturnsViewModelAmount() {
        sut.updateSearchResults(["A", "Different", "test"])
        XCTAssertEqual(sut.tableView(tableView, numberOfRowsInSection: 0), 3)
    }

    func test_cellForRowAtIndexPath_returnsProperlyFormattedCell() {
        let bundle = Bundle(for: SearchResultTableViewCell.self)
        let xib = UINib(nibName: "SearchResultTableViewCell", bundle: bundle)
        tableView.register(xib, forCellReuseIdentifier: "SearchResultTableViewCell")
        sut.updateSearchResults(["A new string"])
        let cell = sut.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! SearchResultTableViewCell
        XCTAssertEqual(cell.characterLabel.text, "A new string")
    }

    // MARK: Helpers

    private let sut = SearchResultDataSourceImpl()
    private let tableView = UITableView()
}
