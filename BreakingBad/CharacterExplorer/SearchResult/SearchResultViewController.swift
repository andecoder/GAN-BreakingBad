//
//  SearchResultViewController.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

protocol SearchResultInteractable {
    func didSelectSearchResult(atIndex: Int)
}

final class SearchResultViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var resultTableView: UITableView!

    private let resultsDataSource: SearchResultDataSource
    private let interactor: SearchResultInteractable

    init(interactor: SearchResultInteractable, resultsDataSource: SearchResultDataSource) {
        self.interactor = interactor
        self.resultsDataSource = resultsDataSource
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        resultsDataSource.bind(to: resultTableView)
        resultTableView.dataSource = resultsDataSource
        resultTableView.delegate = self
        resultTableView.registerNib(ofType: SearchResultTableViewCell.self)
        resultTableView.tableFooterView = UIView()
        resultTableView.backgroundView = blurView
    }

    private lazy var blurView: UIView = {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = resultTableView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.didSelectSearchResult(atIndex: indexPath.row)
    }

    func updateSearchResults(_ results: [String]) {
        resultsDataSource.updateSearchResults(results)
        resultTableView.reloadData()
    }
}

private extension UITableView {

    func registerNib<T: UITableViewCell>(ofType cellType: T.Type) {
        let xibName = String(describing: cellType)
        let bundle = Bundle(for: cellType.self)
        let xib = UINib(nibName: xibName, bundle: bundle)
        register(xib, forCellReuseIdentifier: xibName)
    }
}
