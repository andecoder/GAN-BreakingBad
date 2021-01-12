//
//  CharacterListInteractor.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

protocol CharacterListPresentable {
    func failedToLoadData()
    func show(_: [Character])
}

protocol CharacterListWorkable {
    func loadCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
}

public protocol SearchInteractable {
    func searchCharacters(withName: String)
}

final class CharacterListInteractor: CharacterListInteractable {

    private let presenter: CharacterListPresentable
    private let searchInteractor: SearchInteractable
    private let worker: CharacterListWorkable

    init(presenter: CharacterListPresentable, searchInteractor: SearchInteractable, worker: CharacterListWorkable) {
        self.presenter = presenter
        self.searchInteractor = searchInteractor
        self.worker = worker
    }

    func loadCharacters() {
        worker.loadCharacters { [weak self] result in
            self?.processCharacterResult(result)
        }
    }

    private func processCharacterResult(_ result: Result<[Character], Error>) {
        guard case let .success(characters) = result else {
            return presenter.failedToLoadData()
        }
        presenter.show(characters)
    }

    func searchCharacters(withName name: String) {
        searchInteractor.searchCharacters(withName: name)
    }
}
