//
//  CollectionViewCellProviderTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class CollectionViewCellProviderTests: XCTestCase {

    func test_numberOfItemsInSection_startsWithZeroElements() {
        XCTAssertEqual(sut.collectionView(collectionView, numberOfItemsInSection: 0), 0)
    }

    func test_numberOfItemsInSection_returnsNewViewModelSize() {
        sut.updateViewModels(["A string", "Another string", "Yet another one"])
        XCTAssertEqual(sut.collectionView(collectionView, numberOfItemsInSection: 0), 3)
    }

    func test_cellForItemAtIndexPath_returnsCellCorrectlyPopulated() {
        registerTestXIB()
        sut.updateViewModels(["A string", "Another string", "Yet another one"])
        guard let cell = sut.collectionView(collectionView, cellForItemAt: IndexPath(row: 2, section: 0)) as? CollectionViewCellSpy else {
            return XCTFail("Failed to get cell")
        }
        XCTAssertEqual(cell.receivedText, "Yet another one")
    }

    func test_didSelectItemAtIndexPath_notifiesDelegate() {
        sut.collectionView(collectionView, didSelectItemAt: IndexPath(row: 4, section: 0))
        XCTAssertEqual(spyInteractor.selectedIndex, 4)
    }

    // MARK: Helpers

    private let spyInteractor = CollectionViewInteractorSpy()
    private lazy var sut: CollectionViewCellProvider<CollectionViewCellSpy, String> = CollectionViewCellProvider(interactor: spyInteractor)
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())

    private func registerTestXIB() {
        let bundle = Bundle(for: CollectionViewCellSpy.self)
        let xibName = String(describing: CollectionViewCellSpy.self)
        let xib: UINib = UINib(nibName: xibName, bundle: bundle)
        collectionView.register(xib, forCellWithReuseIdentifier: xibName)
    }
}
