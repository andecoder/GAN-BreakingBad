//
//  MD5HashGenerator.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation
import CryptoKit

final class MD5HashGenerator {

    func hash(_ text: String) -> String {
        guard text.isEmpty == false else {
            return ""
        }

        let data = Data(text.utf8)
        return Insecure.MD5.hash(data: data)
                .map { String(format: "%02hhx", $0) }
                .joined()
    }
}
