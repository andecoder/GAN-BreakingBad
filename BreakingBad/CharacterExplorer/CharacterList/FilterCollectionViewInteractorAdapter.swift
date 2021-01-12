//
//  FilterCollectionViewInteractorAdapter.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

protocol FilterSelectionInteractable {
    func toggleFilter(atIndex: Int)
}

final class FilterCollectionViewInteractorAdapter: CollectionViewInteractor {

    private let interactor: FilterSelectionInteractable

    init(interactor: FilterSelectionInteractable) {
        self.interactor = interactor
    }

    func selectItem(atIndex index: Int) {
        interactor.toggleFilter(atIndex: index)
    }
}
