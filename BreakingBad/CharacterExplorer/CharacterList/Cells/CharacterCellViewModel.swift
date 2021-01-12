//
//  CharacterCellViewModel.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

struct CharacterCellViewModel {
    typealias ImageRequestCallback = (Result<UIImage?, Error>) -> Void

    let id: Int
    let name: String
    let placeholderImageName: String = "placeholder"
    let loadImage: (@escaping ImageRequestCallback) -> Cancellable?
}

extension CharacterCellViewModel {

    static let empty = CharacterCellViewModel(id: -1,
                                              name: "",
                                              loadImage: { _ in return nil })
}
