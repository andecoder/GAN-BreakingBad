//
//  FilterPresenter.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

final class FilterPresenter: CharacterListChildPresenter {

    private let detailsPresenter: CharacterListChildPresenter
    private lazy var cellDataProvider: CollectionViewCellProvider<FilterCollectionViewCell, FilterCellViewModel> = { fatalError("Set on composer before using") }()
    private var seasons: [Int] = []
    private var characters: [Character] = []
    private var selectedFilterIndex: Int?

    init(detailsPresenter: CharacterListChildPresenter) {
        self.detailsPresenter = detailsPresenter
    }

    func bind(to dataProvider: CollectionViewCellProvider<FilterCollectionViewCell, FilterCellViewModel>) {
        cellDataProvider = dataProvider
    }

    func show(_ characters: [Character]) {
        self.characters = characters
        updateSeasons()
        updateViews()
    }

    private func updateSeasons() {
        seasons = characters.map { $0.appearance }
            .reduce(Set<Int>()) { result, appearance in
                result.union(appearance)
            }
            .sorted()
    }

    private func updateViews() {
        updateFilterDataProvider()
        updateDetailsPresenter()
    }

    private func updateFilterDataProvider() {
        let viewModels = seasons.enumerated().map {
            FilterCellViewModel(id: $0.element, name: String(format: "S%02d", $0.element), isSelected: $0.offset == selectedFilterIndex)
        }
        cellDataProvider.updateViewModels(viewModels)
    }

    private func updateDetailsPresenter() {
        guard let index = selectedFilterIndex else {
            return detailsPresenter.show(characters)
        }
        let season = seasons[index]
        showFilteredCharacters(for: season)
    }

    private func showFilteredCharacters(for season: Int) {
        let filteredCharacters = characters.filter { $0.appearance.contains(season) }
        detailsPresenter.show(filteredCharacters)
    }
}

extension FilterPresenter: FilterSelectionInteractable {

    func toggleFilter(atIndex index: Int) {
        guard index < seasons.count else {
            return
        }
        if index == selectedFilterIndex {
            selectedFilterIndex = nil
        } else {
            selectedFilterIndex = index
        }
        updateViews()
    }
}
