//
//  CollectionViewCellSpy.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 11/01/2021.
//

import UIKit
import BreakingBad

final class CollectionViewCellSpy: UICollectionViewCell, CollectionViewCell {
    typealias ViewModel = String

    private(set) var receivedText: String?

    func bind(to viewModel: String) {
        receivedText = viewModel
    }
}
