//
//  SearchResultDataSourceSpy.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit
import BreakingBad

final class SearchResultDataSourceSpy: NSObject, SearchResultDataSource {

    private(set) var receivedResults: [String] = []

    func bind(to: UITableView) { }

    func updateSearchResults(_ results: [String]) {
        receivedResults = results
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
