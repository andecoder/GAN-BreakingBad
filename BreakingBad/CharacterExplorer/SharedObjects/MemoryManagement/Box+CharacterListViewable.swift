//
//  Box+CharacterListViewable.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import Foundation

extension Box: CharacterListViewable where T: CharacterListViewable {

    func dataReceived() {
        element?.dataReceived()
    }

    func failedToLoadData() {
        element?.failedToLoadData()
    }
}
