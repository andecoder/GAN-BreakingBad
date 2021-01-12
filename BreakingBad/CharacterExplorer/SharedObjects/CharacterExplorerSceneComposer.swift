//
//  CharacterExplorerSceneComposer.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

final class CharacterExplorerSceneComposer: CharacterExplorerSceneFactory {

    func makeCharacterListScene() -> UIViewController {
        return CharacterListViewController()
    }

    func makeDetailScene(for character: Character) -> UIViewController {
        return CharacterDetailViewController()
    }
}
