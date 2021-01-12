//
//  CharacterListPresenter.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

protocol CharacterListViewable {
    func dataReceived()
    func failedToLoadData()
}

public protocol CharacterListChildPresenter {
    func show(_: [Character])
}

final class CharacterListPresenter: CharacterListPresentable {

    private lazy var view: CharacterListViewable = { fatalError("Set view before using class") }()
    private let childPresenters: [CharacterListChildPresenter]

    init(childPresenters: [CharacterListChildPresenter]) {
        self.childPresenters = childPresenters
    }

    func bind(to view: CharacterListViewable) {
        self.view = view
    }

    func failedToLoadData() {
        view.failedToLoadData()
    }

    func show(_ characters: [Character]) {
        childPresenters.forEach {
            $0.show(characters)
        }
        view.dataReceived()
    }
}
