//
//  FilterCellViewModel.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

struct FilterCellViewModel {
    let id: Int
    let name: String
    let isSelected: Bool
}

extension FilterCellViewModel {

    static let empty = FilterCellViewModel(id: -1, name: "", isSelected: false)
}
