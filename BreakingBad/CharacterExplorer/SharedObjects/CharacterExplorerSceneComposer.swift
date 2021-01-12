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

    private let imageProvider: ImageProvider
    private let remoteDataProvider: DataProvider

    init(imageProvider: ImageProvider, remoteDataProvider: DataProvider) {
        self.imageProvider = imageProvider
        self.remoteDataProvider = remoteDataProvider
    }

    func makeCharacterListScene(router: CharacterListRoutable) -> UIViewController {
        let characterPresenter = CharacterPresenter(imageProvider: imageProvider, router: router)
        let filterPresenter = FilterPresenter(detailsPresenter: characterPresenter)
        let searchResultPresenter = SearchResultPresenter(router: router)
        let presenter = CharacterListPresenter(childPresenters: [filterPresenter, searchResultPresenter])

        let worker = CharacterListWorker(requester: remoteDataProvider)
        let interactor = CharacterListInteractor(presenter: presenter, searchInteractor: searchResultPresenter, worker: worker)
        let characterProvider: CollectionViewCellProvider<CharacterCollectionViewCell, CharacterCellViewModel> = makeCharacterProvider(using: Box(characterPresenter))
        let filterProvider: CollectionViewCellProvider<FilterCollectionViewCell, FilterCellViewModel> = makeFilterProvider(using: Box(filterPresenter))
        let searchProvider = SearchResultDataSourceImpl()
        let resultController = SearchResultViewController(interactor: Box(searchResultPresenter), resultsDataSource: searchProvider)
        let view = CharacterListViewController(characterDataProvider: characterProvider,
                                               filterDataProvider: filterProvider,
                                               interactor: interactor,
                                               resultsController: resultController)
        presenter.bind(to: Box(view))
        filterPresenter.bind(to: filterProvider)
        characterPresenter.bind(to: characterProvider)
        searchResultPresenter.bind(to: searchProvider)
        return view
    }

    private func makeCharacterProvider(using interactor: CharacterSelectionInteractable) -> CollectionViewCellProvider<CharacterCollectionViewCell, CharacterCellViewModel> {
        let collectionViewInteractor = CharacterCollectionViewInteractorAdapter(interactor: interactor)
        return CollectionViewCellProvider<CharacterCollectionViewCell, CharacterCellViewModel>(interactor: collectionViewInteractor)
    }

    private func makeFilterProvider(using interactor: FilterSelectionInteractable) -> CollectionViewCellProvider<FilterCollectionViewCell, FilterCellViewModel> {
        let collectionViewInteractor = FilterCollectionViewInteractorAdapter(interactor: interactor)
        return CollectionViewCellProvider<FilterCollectionViewCell, FilterCellViewModel>(interactor: collectionViewInteractor)
    }

    func makeDetailScene(for character: Character) -> UIViewController {
        let viewModel = CharacterDetailPresenter.viewModel(for: character)
        return CharacterDetailViewController(imageProvider: imageProvider, viewModel: viewModel)
    }
}
