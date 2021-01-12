//
//  CharacterPresenter.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

final class CharacterPresenter: CharacterListChildPresenter {

    private let imageProvider: ImageProvider
    private let router: CharacterListRoutable
    private lazy var cellDataProvider: CollectionViewCellProvider<CharacterCollectionViewCell, CharacterCellViewModel> = { fatalError("Set on composer before using") }()
    private var characters: [Character] = []

    init(imageProvider: ImageProvider, router: CharacterListRoutable) {
        self.imageProvider = imageProvider
        self.router = router
    }

    func bind(to dataProvider: CollectionViewCellProvider<CharacterCollectionViewCell, CharacterCellViewModel>) {
        cellDataProvider = dataProvider
    }

    func show(_ characters: [Character]) {
        self.characters = characters
        updateDataProvider()
    }

    private func updateDataProvider() {
        let viewModels = characters.map { [imageProvider] character in
            CharacterCellViewModel(id: character.id, name: character.name) { completion in
                imageProvider.fetchImage(from: character.imageUrl, completion: completion)
            }
        }
        cellDataProvider.updateViewModels(viewModels)
    }
}

extension CharacterPresenter: CharacterSelectionInteractable {

    func selectCharacter(atIndex index: Int) {
        guard index < characters.count else {
            return
        }
        let character = characters[index]
        router.displayDetails(for: character)
    }
}
