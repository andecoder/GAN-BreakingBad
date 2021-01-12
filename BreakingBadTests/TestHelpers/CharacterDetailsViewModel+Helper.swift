//
//  CharacterDetailsViewModel+Helper.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation
@testable import BreakingBad

extension CharacterDetailViewModel: Equatable {

    public static let testObject = CharacterDetailViewModel(name: "A character",
                                                             nickName: "Something",
                                                             occupation: "Nothing",
                                                             status: "Dead",
                                                             seasonAppearance: "Season 3",
                                                             imageURL: URL(string: "www.mwangops.co.uk")!,
                                                             viewCornerRadius: 25)

    public static func ==(lhs: CharacterDetailViewModel, rhs: CharacterDetailViewModel) -> Bool {
        return lhs.name == rhs.name
            && lhs.nickName == rhs.nickName
            && lhs.occupation == rhs.occupation
            && lhs.status == rhs.status
            && lhs.seasonAppearance == rhs.seasonAppearance
            && lhs.imageURL == rhs.imageURL
            && lhs.viewCornerRadius == rhs.viewCornerRadius
    }
}
