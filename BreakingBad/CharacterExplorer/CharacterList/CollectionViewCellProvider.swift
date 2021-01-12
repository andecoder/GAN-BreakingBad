//
//  CollectionViewCellProvider.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

public protocol CollectionViewCell {
    associatedtype ViewModel

    func bind(to: ViewModel)
}
