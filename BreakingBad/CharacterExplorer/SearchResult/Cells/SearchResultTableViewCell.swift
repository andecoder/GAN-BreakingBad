//
//  SearchResultTableViewCell.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

final class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var characterLabel: UILabel!

    var viewModel: SearchResultCellViewModel = .empty {
        didSet {
            characterLabel.text = viewModel.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        characterLabel.text = ""
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        viewModel = .empty
    }

    func bind(to viewModel: SearchResultCellViewModel) {
        self.viewModel = viewModel
    }
}
