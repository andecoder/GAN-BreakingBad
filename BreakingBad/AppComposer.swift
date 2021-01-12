//
//  AppComposer.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

protocol DependencyFactory {
    var rootViewController: UIViewController { get }
    var mainRouter: Routable { get }
}

protocol Routable {
    func displayFirstScreen()
}

final class AppComposer {

    private let dependenciesProvider: DependencyFactory

    private var rootVC: UIViewController {
        return dependenciesProvider.rootViewController
    }
    private var router: Routable {
        return dependenciesProvider.mainRouter
    }

    init(dependencyProvider: DependencyFactory, window: UIWindow) {
        self.dependenciesProvider = dependencyProvider
        window.rootViewController = rootVC
    }

    func launchInitialScreen() {
        router.displayFirstScreen()
    }
}
