//
//  SearchResultCellViewModel.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

struct SearchResultCellViewModel {
    let id: Int
    let name: String
}

extension SearchResultCellViewModel {

    static let empty = SearchResultCellViewModel(id: -1, name: "")
}
