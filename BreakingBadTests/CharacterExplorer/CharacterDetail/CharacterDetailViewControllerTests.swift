//
//  CharacterDetailViewControllerTests.swift
//  BreakingBadTests
//
//  Created by Anderson Costa on 12/01/2021.
//

import XCTest
@testable import BreakingBad

final class CharacterDetailViewControllerTests: XCTestCase {

    func test_whenViewLoads_asksProviderForImage() {
        let spyImageProvider = ImageProviderSpy()
        _ = makeSut(imageProvider: spyImageProvider)
        XCTAssertEqual(spyImageProvider.fetchedImageURL, viewModel.imageURL)
    }

    func test_whenViewLoads_setsLabelsText() {
        let sut: CharacterDetailViewController = makeSut()
        XCTAssertEqual(sut.nicknameLabel.text, viewModel.nickName)
        XCTAssertEqual(sut.nameLabel.text, viewModel.name)
        XCTAssertEqual(sut.occupationLabel.text, viewModel.occupation)
        XCTAssertEqual(sut.statusLabel.text, viewModel.status)
        XCTAssertEqual(sut.seasonAppearanceLabel.text, viewModel.seasonAppearance)
    }

    func test_whenViewLoads_roundsChildViewCorners() {
        let sut: CharacterDetailViewController = makeSut()
        [sut.characterImage, sut.nicknameBgView, sut.detailsBgView].forEach { view in
            XCTAssertEqual(view?.layer.cornerRadius, CGFloat(viewModel.viewCornerRadius))
            XCTAssertTrue(view?.clipsToBounds ?? false)
        }
    }

    func test_whenImageLoadSucceeds_updateCharacterImage() {
        let spyImageProvider = ImageProviderSpy()
        let resultImage = UIImage(named: "background")!
        spyImageProvider.fetchImageReturns = .success(resultImage)
        let sut: CharacterDetailViewController = makeSut(imageProvider: spyImageProvider)
        let promise = XCTKVOExpectation(keyPath: "image", object: sut.characterImage!)
        _ = XCTWaiter().wait(for: [promise], timeout: 1)
        XCTAssertEqual(sut.characterImage.image?.pngData(), resultImage.pngData())
    }

    func test_whenImageLoadFails_keepPlaceholderImage() {
        let spyImageProvider = ImageProviderSpy()
        let expectedImage = UIImage(named: "placeholder")!
        spyImageProvider.fetchImageReturns = .failure(URLError(.badURL))
        let sut: CharacterDetailViewController = makeSut(imageProvider: spyImageProvider)
        XCTAssertEqual(sut.characterImage.image?.pngData(), expectedImage.pngData())
    }

    func test_whenViewDestroyed_cancelsPendingRequest() {
        let spyCancellable = CancellableSpy()
        let spyImageProvider = ImageProviderSpy(cancellable: spyCancellable)
        autoreleasepool {
            _ = makeSut(imageProvider: spyImageProvider)
        }
        XCTAssertTrue(spyCancellable.cancelCalled)
    }

    // MARK: Helpers

    private let viewModel: CharacterDetailViewModel = .testObject

    private func makeSut(imageProvider: ImageProvider = ImageProviderSpy()) -> CharacterDetailViewController {
        let sut = CharacterDetailViewController(imageProvider: imageProvider, viewModel: viewModel)
        _ = sut.view
        return sut
    }
}
