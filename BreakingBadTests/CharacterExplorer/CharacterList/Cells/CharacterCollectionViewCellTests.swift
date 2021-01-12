//
//  CharacterCollectionViewCellTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class CharacterCollectionViewCellTests: XCTestCase {

    func test_bindToViewModel_updatesCharacterNameLabel() {
        let sut: CharacterCollectionViewCell = makeSUT()
        let viewModel = CharacterCellViewModel(id: 23, name: "Somebody", loadImage: { _ in return nil })
        sut.bind(to: viewModel)
        XCTAssertEqual(sut.nameLabel.text, viewModel.name)
    }

    func test_bindToViewModel_fetchesImageUsingViewModel() {
        let sut: CharacterCollectionViewCell = makeSUT()
        let expectation = XCTestExpectation()
        let viewModel = CharacterCellViewModel(id: 23, name: "Somebody", loadImage: { _ in
            expectation.fulfill()
            return nil
        })
        sut.bind(to: viewModel)
        wait(for: [expectation], timeout: 0.1)
    }

    // MARK: Helpers

    private func makeSUT() -> CharacterCollectionViewCell {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.registerNib(ofType: CharacterCollectionViewCell.self)
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath)
        return cell as! CharacterCollectionViewCell
    }
}
