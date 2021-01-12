//
//  BreakingBadSnapshotTests.swift
//  BreakingBadSnapshotTests
//
//  Created by Anderson Costa on 11/01/2021.
//

import XCTest
import SnapshotTesting
@testable import BreakingBad

final class BreakingBadSnapshotTests: XCTestCase {

    func testApp() throws {
        LayoutConfigurator.applyLayoutAppearance()
        let dependenciesProvider = MockDependenciesProvider()
        let appComposer = AppComposer(dependencyProvider: dependenciesProvider, window: UIWindow())
        appComposer.launchInitialScreen()
        assertSnapshot(matching: dependenciesProvider.rootViewController, as: .image)

        let character = Character(id: 20, name: "UI Testing", occupation: ["Snapshot"], imageUrl: URL(string: "www.google.com")!, status: "Alive and well", nickName: "Automated testing", appearance: [1, 2, 3, 4, 5])
        (dependenciesProvider.mainRouter as! CharacterExplorerRouter).displayDetails(for: character)
        assertSnapshot(matching: dependenciesProvider.rootViewController, as: .image)
    }
}

private final class MockDependenciesProvider: DependencyFactory {
    let navController = UINavigationController()
    var rootViewController: UIViewController { navController }
    lazy var sceneFactory: CharacterExplorerSceneFactory = CharacterExplorerSceneComposer(imageProvider: FakeImageProvider(),
                                                                                          remoteDataProvider: FakeRemoteRequester())
    lazy var mainRouter: Routable = CharacterExplorerRouter(navigationController: navController,
                                                            sceneFactory: sceneFactory)

    final class FakeImageProvider: ImageProvider {

        func fetchImage(from url: URL, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable {
            let bundle = Bundle(for: BreakingBadSnapshotTests.self)
            let imageURL = bundle.url(forResource: "snapshot", withExtension: "jpg")!
            let image = UIImage(contentsOfFile: imageURL.path)
            completion(.success(image))
            return FakeCancellable()
        }
    }

    final class FakeCancellable: Cancellable {

        func cancel() { }
    }

    final class FakeRemoteRequester: DataProvider {

        func fetchData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> Cancellable {
            let bundle = Bundle(for: BreakingBadSnapshotTests.self)
            let jsonURL = bundle.url(forResource: "response", withExtension: "json")!
            let data = try! Data(contentsOf: jsonURL)
            completion(.success(data))
            return FakeCancellable()
        }
    }
}
