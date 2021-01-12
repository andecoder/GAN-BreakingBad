//
//  iPhoneDependencyProvider.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

final class iPhoneDependencyProvider: DependencyFactory {

    private let navController = UINavigationController()
    var rootViewController: UIViewController {
        return navController
    }
    private let remoteRequester: DataProvider = URLSession.shared
    private lazy var imageProvider: ImageProvider = CacheableImageProvider(hasher: MD5HashGenerator(),
                                                                      localImageProvider: FileManager.default,
                                                                      remoteImageProvider: RemoteImageProvider(requester: remoteRequester))
    private lazy var sceneFactory: CharacterExplorerSceneFactory = CharacterExplorerSceneComposer(imageProvider: imageProvider,
                                                                                                  remoteDataProvider: remoteRequester)
    private(set) lazy var mainRouter: Routable = CharacterExplorerRouter(navigationController: navController, sceneFactory: sceneFactory)
}
