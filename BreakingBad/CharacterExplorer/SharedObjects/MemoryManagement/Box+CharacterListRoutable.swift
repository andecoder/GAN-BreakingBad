//
//  Box+CharacterListRoutable.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

extension Box: CharacterListRoutable where T: CharacterListRoutable {

    func displayDetails(for character: Character) {
        element?.displayDetails(for: character)
    }
}
