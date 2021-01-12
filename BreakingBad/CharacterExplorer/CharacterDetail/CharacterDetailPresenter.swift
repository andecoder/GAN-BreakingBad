//
//  CharacterDetailPresenter.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

enum CharacterDetailPresenter {

    static func viewModel(for character: Character) -> CharacterDetailViewModel {
        return CharacterDetailViewModel(name: character.name,
                                         nickName: character.nickName,
                                         occupation: occupationString(for: character),
                                         status: character.status,
                                         seasonAppearance: appearanceString(for: character),
                                         imageURL: character.imageUrl,
                                         viewCornerRadius: 15.0)
    }

    private static func occupationString(for character: Character) -> String {
        return character.occupation.joined(separator: "\n")
    }

    private static func appearanceString(for character: Character) -> String {
        return character.appearance
            .map { "Season \($0)" }
            .joined(separator: "\n")
    }
}
