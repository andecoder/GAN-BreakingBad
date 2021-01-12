//
//  CharacterExplorerRouterTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class CharacterExplorerRouterTests: XCTestCase {

    func test_displayFirstScreen_pushesTheCorrectScreenToNavStack() {
        XCTAssertTrue(navController.viewControllers.isEmpty)
        sut.displayFirstScreen()
        XCTAssertEqual(navController.viewControllers.count, 1)
        XCTAssertEqual(navController.topViewController, spySceneFactory.vcToReturn)
    }

    func test_displayDetailsForCharacter_forwardsTheCorrectObject() {
        let character: Character = .testObject
        sut.displayDetails(for: character)
        XCTAssertEqual(spySceneFactory.displayedCharacter, character)
    }

    func test_displayDetailsForCharacter_pushesTheCorrectScreenToNavStack() {
        XCTAssertTrue(navController.viewControllers.isEmpty)
        sut.displayDetails(for: .testObject)
        XCTAssertEqual(navController.viewControllers.count, 1)
        XCTAssertEqual(navController.topViewController, spySceneFactory.vcToReturn)
    }

    // MARK: Helpers

    private let navController = UINavigationController()
    private let spySceneFactory = CharacterExplorerSceneFactorySpy()
    private lazy var sut = CharacterExplorerRouter(navigationController: navController, sceneFactory: spySceneFactory)

    private final class CharacterExplorerSceneFactorySpy: CharacterExplorerSceneFactory {

        private(set) var receivedRouter: CharacterListRoutable?
        var vcToReturn = UIViewController()
        var displayedCharacter: Character?

        func makeCharacterListScene(router: CharacterListRoutable) -> UIViewController {
            return vcToReturn
        }

        func makeDetailScene(for character: Character) -> UIViewController {
            displayedCharacter = character
            return vcToReturn
        }
    }
}
