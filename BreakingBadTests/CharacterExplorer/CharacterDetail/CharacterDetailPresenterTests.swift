//
//  CharacterDetailPresenterTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class CharacterDetailPresenterTests: XCTestCase {

    func test_viewModelForCharacter_createsViewModelWithCorrectData() {
        let viewModel = CharacterDetailPresenter.viewModel(for: .testObject)
        XCTAssertEqual(viewModel.name, "A breaking bad character")
        XCTAssertEqual(viewModel.nickName, "Swift Dev")
        XCTAssertEqual(viewModel.occupation, "Software Developer\niOS Programmer")
        XCTAssertEqual(viewModel.status, "Alive")
        XCTAssertEqual(viewModel.seasonAppearance, "Season 2\nSeason 3\nSeason 4")
        XCTAssertEqual(viewModel.imageURL.absoluteString, "www.google.com")
        XCTAssertEqual(viewModel.viewCornerRadius, 15)
    }
}
