//
//  CharacterExplorerSceneComposer.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

public protocol CharacterListRoutable {
    func displayDetails(for: Character)
}

final class CharacterExplorerSceneComposer: CharacterExplorerSceneFactory {

    private final class FakeDataProvider: CollectionViewDataProvider {

        func bind(to: UICollectionView) { }
    }

    private final class FakeInteractor: CharacterListInteractable {

        func loadCharacters() { }

        func searchCharacters(withName: String) { }
    }

    private final class FakeImageProvider: ImageProvider {

        func fetchImage(from url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable {
            return FakeCancellable()
        }
    }

    private final class FakeCancellable: Cancellable {

        func cancel() { }
    }

    func makeCharacterListScene() -> UIViewController {
        return CharacterListViewController(characterDataProvider: FakeDataProvider(), filterDataProvider: FakeDataProvider(), interactor: FakeInteractor(), resultsController: UIViewController())
    }

    func makeDetailScene(for character: Character) -> UIViewController {
        let viewModel = CharacterDetailViewModel(name: "", nickName: "", occupation: "", status: "", seasonAppearance: "", imageURL: URL(string: "www.google.com")!, viewCornerRadius: 1)
        return CharacterDetailViewController(imageProvider: FakeImageProvider(), viewModel: viewModel)
    }
}
