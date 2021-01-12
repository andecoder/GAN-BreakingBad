//
//  CharacterListChildPresenterSpy.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation
import BreakingBad

final class CharacterListChildPresenterSpy: CharacterListChildPresenter {

    private(set) var showedCharacters: [Character] = []

    func show(_ characters: [Character]) {
        showedCharacters = characters
    }
}
