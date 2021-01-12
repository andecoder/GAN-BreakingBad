//
//  AppComposerTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class AppComposerTests: XCTestCase {

    func test_init_setsTheRootVcOfWindowToFactoryRootViewController() {
        let spyDependencyProvider = DependencyFactorySpy()
        let window = UIWindow()
        _ = makeSUT(dependencyProvider: spyDependencyProvider, window: window)
        XCTAssertEqual(window.rootViewController, spyDependencyProvider.rootViewController)
    }

    func test_launchInitialScreen_callsDisplayFirstScreenOnRouter() {
        let spyRoutable = RoutableSpy()
        let sut = makeSUT(dependencyProvider: DependencyFactorySpy(router: spyRoutable))
        sut.launchInitialScreen()
        XCTAssertTrue(spyRoutable.displayFirstScreenCalled)
    }

    // MARK: Helpers

    private func makeSUT(dependencyProvider: DependencyFactory = DependencyFactorySpy(), window: UIWindow = UIWindow()) -> AppComposer {
        return AppComposer(dependencyProvider: dependencyProvider, window: window)
    }

    private final class DependencyFactorySpy: DependencyFactory {

        let rootViewController = UIViewController()
        let mainRouter: Routable

        init(router: Routable = RoutableSpy()) {
            mainRouter =  router
        }
    }

    private final class RoutableSpy: Routable {

        private(set) var displayFirstScreenCalled: Bool = false

        func displayFirstScreen() {
            displayFirstScreenCalled = true
        }
    }
}
