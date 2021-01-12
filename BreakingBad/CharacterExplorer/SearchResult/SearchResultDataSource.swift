//
//  SearchResultDataSource.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

public protocol SearchResultDataSource: UITableViewDataSource {
    func updateSearchResults(_: [String])
}

final class SearchResultDataSourceImpl: NSObject, SearchResultDataSource {

    private var searchResults: [String] = []

    func updateSearchResults(_ searchResults: [String]) {
        self.searchResults = searchResults
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(ofType: SearchResultTableViewCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        let characterName: String = searchResults[indexPath.row]
        cell.characterLabel.text = characterName
        return cell
    }
}

private extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(ofType: T.Type, for indexPath: IndexPath) -> T? {
        let reuseIdentifier = String(describing: T.self)
        let cell = dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        return cell as? T
    }
}
