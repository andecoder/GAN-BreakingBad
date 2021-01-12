//
//  Character+Helper.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation
@testable import BreakingBad

extension Character: Equatable {

    public static let testObject = Character(id: 100,
                                      name: "A breaking bad character",
                                      occupation: ["Software Developer", "iOS Programmer"],
                                      imageUrl: URL(string: "www.google.com")!,
                                      status: "Alive",
                                      nickName: "Swift Dev",
                                      appearance: [2, 3, 4])

    public static func ==(lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
            && lhs.name == rhs.name
            && lhs.occupation == rhs.occupation
            && lhs.imageUrl == rhs.imageUrl
            && lhs.status == rhs.status
            && lhs.nickName == rhs.nickName
            && lhs.appearance == rhs.appearance
    }
}
