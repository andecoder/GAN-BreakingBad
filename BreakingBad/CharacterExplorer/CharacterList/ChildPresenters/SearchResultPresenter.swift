//
//  SearchResultPresenter.swift
//  BreakingBad
//
//  Created by Anderson Costa on 11/01/2021.
//

import Foundation

final class SearchResultPresenter: CharacterListChildPresenter {

    private lazy var cellDataProvider: SearchResultDataSource = { fatalError("Set on composer before using") }()
    private let router: CharacterListRoutable
    private var characters: [Character] = []
    private var searchResultCharacters: [Character] = []

    init(router: CharacterListRoutable) {
        self.router = router
    }

    func bind(to dataProvider: SearchResultDataSource) {
        cellDataProvider = dataProvider
    }

    func show(_ characters: [Character]) {
        self.characters = characters
        searchResultCharacters = characters
        updateDataProvider()
    }

    private func updateDataProvider() {
        let names = searchResultCharacters.map { $0.name }
        cellDataProvider.updateSearchResults(names)
    }
}

extension SearchResultPresenter: SearchInteractable {

    func searchCharacters(withName name: String) {
        searchResultCharacters = characters.filter { $0.name.contains(name) }
        updateDataProvider()
    }
}

extension SearchResultPresenter: SearchResultInteractable {

    func didSelectSearchResult(atIndex index: Int) {
        let character = searchResultCharacters[index]
        router.displayDetails(for: character)
    }
}
