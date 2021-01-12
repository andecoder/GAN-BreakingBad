//
//  Character.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

struct Character: Codable {

    enum CodingKeys: String, CodingKey {
        case id = "char_id"
        case imageUrl = "img"
        case nickName = "nickname"
        case name, occupation, status, appearance
    }

    let id: Int
    let name: String
    let occupation: [String]
    let imageUrl: URL
    let status: String
    let nickName: String
    let appearance: [Int]
}
