//
//  CharacterListRouterSpy.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation
import BreakingBad

final class CharacterListRouterSpy: CharacterListRoutable {

    private(set) var displayedCharacter: Character?

    func displayDetails(for character: Character) {
        displayedCharacter = character
    }
}
