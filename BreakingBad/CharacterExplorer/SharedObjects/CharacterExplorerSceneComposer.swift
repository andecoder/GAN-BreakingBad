//
//  CharacterExplorerSceneComposer.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

final class CharacterExplorerSceneComposer: CharacterExplorerSceneFactory {

    private final class FakeDataProvider: CollectionViewDataProvider {

        func bind(to: UICollectionView) { }
    }

    private final class FakeInteractor: CharacterListInteractable {

        func loadCharacters() { }

        func searchCharacters(withName: String) { }
    }

    func makeCharacterListScene() -> UIViewController {
        return CharacterListViewController(characterDataProvider: FakeDataProvider(), filterDataProvider: FakeDataProvider(), interactor: FakeInteractor(), resultsController: UIViewController())
    }

    func makeDetailScene(for character: Character) -> UIViewController {
        return CharacterDetailViewController()
    }
}
