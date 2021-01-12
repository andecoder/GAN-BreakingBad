//
//  CharacterCollectionViewInteractorAdapter.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

protocol CharacterSelectionInteractable {
    func selectCharacter(atIndex: Int)
}

final class CharacterCollectionViewInteractorAdapter: CollectionViewInteractor {

    private let interactor: CharacterSelectionInteractable

    init(interactor: CharacterSelectionInteractable) {
        self.interactor = interactor
    }

    func selectItem(atIndex index: Int) {
        interactor.selectCharacter(atIndex: index)
    }
}
