//
//  CharacterListWorkerTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class CharacterListWorkerTests: XCTestCase {

    private let testURL: URL = URL(string: "www.google.com")!
    private let spyProvider = DataProviderSpy()
    private lazy var sut = CharacterListWorker(requester: spyProvider, resourceURL: testURL)
    private let expectedCharacter = Character(id: 1,
                                              name: "Walter White",
                                              occupation: ["High School Chemistry Teacher", "Meth King Pin"],
                                              imageUrl: URL(string: "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")!,
                                              status: "Presumed dead",
                                              nickName: "Heisenberg",
                                              appearance: [1, 2, 3, 4, 5])

    func test_loadCharacters_sendsCorrectURLtoRequester() {
        sut.loadCharacters { (_: Result<[Character], Error>) in }
        XCTAssertEqual(spyProvider.requestedURL, testURL)
    }

    func test_loadCharacters_successfullyDecodesValidSingleObject() {
        let successResponse = """
        [{"char_id": 1, "name": "Walter White", "birthday": "09-07-1958", "occupation": ["High School Chemistry Teacher", "Meth King Pin"], "img": "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg", "status": "Presumed dead", "nickname": "Heisenberg", "appearance": [1, 2, 3, 4, 5], "portrayed": "Bryan Cranston", "category": "Breaking Bad", "better_call_saul_appearance": []}]
        """
        let successData = Data(successResponse.utf8)
        spyProvider.fetchDataReturns = [.success(successData)]
        let expectation = XCTestExpectation()
        sut.loadCharacters { (result: Result<[Character], Error>) in
            guard case let .success(characters) = result else {
                return XCTFail("Failed to get model")
            }
            XCTAssertEqual(characters, [self.expectedCharacter])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_loadCharacters_emitsErrorIfDecodingFails() {
        let jsonResponse = "invalid json"
        let jsonData = Data(jsonResponse.utf8)
        spyProvider.fetchDataReturns = [.success(jsonData)]
        let expectation = XCTestExpectation()
        sut.loadCharacters { (result: Result<[Character], Error>) in
            guard case .failure = result else {
                return XCTFail("Failed to get error")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_loadCharacters_successfullyDecodesValidArrayOfObjectsByFilteringInvalidObjects() {
        let successResponse = """
        [{"char_id": 1, "name": "Walter White", "birthday": "09-07-1958", "occupation": ["High School Chemistry Teacher", "Meth King Pin"], "img": "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg", "status": "Presumed dead", "nickname": "Heisenberg", "appearance": [1, 2, 3, 4, 5], "portrayed": "Bryan Cranston", "category": "Breaking Bad", "better_call_saul_appearance": []},
        {"char_id": 112, "name": "Kimberly Wexler", "birthday": "Unknown", "occupation": ["Lawyer"], "img": "https://vignette.wikia.nocookie.net/breakingbad/images/f/f7/BCS_S4_Kim_Wexler.jpg/revision/latest?cb=20180824195845", "status": "Alive", "nickname": "Kim", "appearance": null, "portrayed": "Rhea Seehorn", "category": "Better Call Saul", "better_call_saul_appearance": [1, 2, 3, 4, 5]}]
        """
        let successData = Data(successResponse.utf8)
        spyProvider.fetchDataReturns = [.success(successData)]
        let expectation = XCTestExpectation()
        sut.loadCharacters { (result: Result<[Character], Error>) in
            guard case let .success(characters) = result else {
                return XCTFail("Failed to get model")
            }
            XCTAssertEqual(characters, [self.expectedCharacter])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }

    func test_loadCharacters_forwardsErrorsFromRequester() {
        let cancelledError = URLError(.cancelled)
        spyProvider.fetchDataReturns = [.failure(cancelledError)]
        let expectation = XCTestExpectation()
        sut.loadCharacters { (result: Result<[Character], Error>) in
            guard case let .failure(error) = result, let returnedError = error as? URLError else {
                return XCTFail("Failed to get error")
            }
            XCTAssertEqual(returnedError, cancelledError)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
    }
}
