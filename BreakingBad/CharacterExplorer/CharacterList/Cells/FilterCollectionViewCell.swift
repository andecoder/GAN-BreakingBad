//
//  FilterCollectionViewCell.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell, CollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var seasonLabel: UILabel!

    private(set) var viewModel: FilterCellViewModel = .empty {
        didSet {
            seasonLabel.text = viewModel.name
            containerView.backgroundColor = containerBgColor
        }
    }
    private var containerBgColor: UIColor {
        let selectedBgColor = UIColor(red: 3 / 255.0, green: 3 / 255.0, blue: 3 / 255.0, alpha: 1)
        let deselectedBgColor = UIColor(red: 12 / 255.0, green: 105 / 255.0, blue: 55 / 255.0, alpha: 0.3)
        return viewModel.isSelected ? selectedBgColor : deselectedBgColor
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        seasonLabel.text = viewModel.name
        containerView.backgroundColor = containerBgColor
        stylishContainerView()
    }

    private func stylishContainerView() {
        roundContainerViewCorners()
        addDropShadowToContainerView()
        addBorderToContainerView()
        addBlurToContainerView()
    }

    private func roundContainerViewCorners() {
        containerView.clipsToBounds = true
        let containerViewWidth: CGFloat = containerView.frame.width
        containerView.layer.cornerRadius = containerViewWidth / 2
    }

    private func addDropShadowToContainerView() {
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowRadius = 5
        containerView.layer.shadowOpacity = 0.25
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
    }

    private func addBorderToContainerView() {
        let borderColor = UIColor(red: 216 / 255.0, green: 216 / 255.0, blue: 216 / 255.0, alpha: 0.3)
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = borderColor.cgColor
    }

    private func addBlurToContainerView() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = containerView.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.addSubview(blurView)
        containerView.sendSubviewToBack(blurView)
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        resetData()
    }

    private func resetData() {
        viewModel = .empty
    }

    func bind(to viewModel: FilterCellViewModel) {
        self.viewModel = viewModel
    }
}
