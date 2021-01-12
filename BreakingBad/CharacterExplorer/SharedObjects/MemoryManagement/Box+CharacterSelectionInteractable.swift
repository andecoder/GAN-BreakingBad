//
//  Box+CharacterSelectionInteractable.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

extension Box: CharacterSelectionInteractable where T: CharacterSelectionInteractable {

    func selectCharacter(atIndex index: Int) {
        element?.selectCharacter(atIndex: index)
    }
}
