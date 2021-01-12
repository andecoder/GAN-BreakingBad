//
//  SearchResultTableViewCellTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class SearchResultTableViewCellTests: XCTestCase {

    func test_bindToViewModel_updatesLabelText() {
        let tableView = UITableView()
        let bundle = Bundle(for: SearchResultTableViewCell.self)
        let xib = UINib(nibName: "SearchResultTableViewCell", bundle: bundle)
        tableView.register(xib, forCellReuseIdentifier: "SearchResultTableViewCell")
        let sut = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as! SearchResultTableViewCell
        let viewModel = SearchResultCellViewModel(id: 100, name: "A test")
        sut.bind(to: viewModel)
        XCTAssertEqual(sut.characterLabel.text, viewModel.name)
    }
}
