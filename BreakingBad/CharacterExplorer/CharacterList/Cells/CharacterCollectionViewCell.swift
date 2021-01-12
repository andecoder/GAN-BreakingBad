//
//  CharacterCollectionViewCell.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

final class CharacterCollectionViewCell: UICollectionViewCell, CollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!

    private var imageRequest: Cancellable?
    private(set) var viewModel: CharacterCellViewModel = .empty {
        didSet {
            nameLabel.text = viewModel.name
            characterImageView.image = placeholderImage
            imageRequest = viewModel.loadImage { [onResultReceived] result in
                onResultReceived(result)
            }
        }
    }
    private var placeholderImage: UIImage? {
        return UIImage(named: viewModel.placeholderImageName)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        nameLabel.text = viewModel.name
        stylishContainerView()
    }

    private func stylishContainerView() {
        roundContainerViewCorners()
        addDropShadowToContainerView()
    }

    private func roundContainerViewCorners() {
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 15
    }

    private func addDropShadowToContainerView() {
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowOpacity = 0.25
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        resetData()
    }

    private func resetData() {
        imageRequest?.cancel()
        imageRequest = nil
        viewModel = .empty
    }

    func bind(to viewModel: CharacterCellViewModel) {
        self.viewModel = viewModel
    }

    private func onResultReceived(_ result: Result<UIImage?, Error>) {
        imageRequest = nil
        guard case let .success(resultImage) = result, let image = resultImage else {
            return
        }
        DispatchQueue.main.async {
            self.characterImageView.image = image
        }
    }
}
