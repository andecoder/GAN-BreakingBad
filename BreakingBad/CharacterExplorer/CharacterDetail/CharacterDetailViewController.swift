//
//  CharacterDetailViewController.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

final class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nicknameBgView: UIView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var detailsBgView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var seasonAppearanceLabel: UILabel!

    private let imageProvider: ImageProvider
    private let viewModel: CharacterDetailViewModel

    private(set) var imageRequest: Cancellable?

    init(imageProvider: ImageProvider, viewModel: CharacterDetailViewModel) {
        self.imageProvider = imageProvider
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        roundViews()
        bindToViewModel()
    }

    private func roundViews() {
        [characterImage, nicknameBgView, detailsBgView].forEach { view in
            view?.clipsToBounds = true
            view?.layer.cornerRadius = CGFloat(viewModel.viewCornerRadius)
        }
    }

    private func bindToViewModel() {
        loadImage()
        setTextToLabels()
    }

    private func loadImage() {
        imageRequest = imageProvider.fetchImage(from: viewModel.imageURL) { [weak self] result in
            self?.imageRequest = nil
            guard case let .success(image) = result else {
                return
            }
            DispatchQueue.main.async {
                self?.characterImage.image = image
            }
        }
    }

    private func setTextToLabels() {
        nicknameLabel.text = viewModel.nickName
        nameLabel.text = viewModel.name
        occupationLabel.text = viewModel.occupation
        statusLabel.text = viewModel.status
        seasonAppearanceLabel.text = viewModel.seasonAppearance
    }

    deinit {
        imageRequest?.cancel()
    }
}
