//
//  CharacterExplorerRouter.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

protocol CharacterExplorerSceneFactory {
    func makeCharacterListScene(router: CharacterListRoutable) -> UIViewController
    func makeDetailScene(for: Character) -> UIViewController
}

final class CharacterExplorerRouter: Routable, CharacterListRoutable {

    private let navigationController: UINavigationController
    private let sceneFactory: CharacterExplorerSceneFactory

    init(navigationController: UINavigationController, sceneFactory: CharacterExplorerSceneFactory) {
        self.navigationController = navigationController
        self.sceneFactory = sceneFactory
    }

    func displayFirstScreen() {
        displayCharacterList()
    }

    private func displayCharacterList() {
        let viewController: UIViewController = sceneFactory.makeCharacterListScene(router: Box(self))
        navigationController.pushViewController(viewController, animated: true)
    }

    func displayDetails(for character: Character) {
        let viewController: UIViewController = sceneFactory.makeDetailScene(for: character)
        navigationController.pushViewController(viewController, animated: true)
    }
}
