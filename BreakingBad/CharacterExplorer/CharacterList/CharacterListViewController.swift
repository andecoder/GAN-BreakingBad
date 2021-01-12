//
//  CharacterListViewController.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

protocol CharacterListInteractable {
    func loadCharacters()
    func searchCharacters(withName: String)
}

protocol CollectionViewDataProvider {
    func bind(to: UICollectionView)
}

final class CharacterListViewController: UIViewController, CharacterListViewable {

    @IBOutlet weak var filterLabel: UILabel!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var charactersCollectionView: UICollectionView!

    let characterDataProvider: CollectionViewDataProvider
    let filterDataProvider: CollectionViewDataProvider
    let interactor: CharacterListInteractable
    let searchController: UISearchController
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        return refreshControl
    }()

    init(characterDataProvider: CollectionViewDataProvider, filterDataProvider: CollectionViewDataProvider, interactor: CharacterListInteractable, resultsController: UIViewController) {
        self.characterDataProvider = characterDataProvider
        self.filterDataProvider = filterDataProvider
        self.interactor = interactor
        self.searchController = UISearchController(searchResultsController: resultsController)
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        loadData()
    }

    private func configureView() {
        bindCollectionViewsToDataProviders()
        registerCells()
        configureNavBar()
        addSearchBar()
        charactersCollectionView.refreshControl = refreshControl
    }

    private func bindCollectionViewsToDataProviders() {
        filterDataProvider.bind(to: filterCollectionView)
        characterDataProvider.bind(to: charactersCollectionView)
    }

    private func registerCells() {
        filterCollectionView.registerNib(ofType: FilterCollectionViewCell.self)
        charactersCollectionView.registerNib(ofType: CharacterCollectionViewCell.self)
    }

    private func configureNavBar() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "characters"))
        navigationItem.backButtonTitle = ""
    }

    private func addSearchBar() {
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    @objc
    private func loadData() {
        refreshControl.beginRefreshing()
        interactor.loadCharacters()
    }

    func dataReceived() {
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.filterLabel.isHidden = false
        }
    }

    func failedToLoadData() {
        let alertController = UIAlertController(title: "Error...", message: "We couldn't get the data!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension CharacterListViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            return
        }
        interactor.searchCharacters(withName: searchText)
    }
}

extension UICollectionView {

    func registerNib<T: UICollectionViewCell>(ofType cellType: T.Type) {
        let xibName = String(describing: cellType)
        let bundle = Bundle(for: cellType.self)
        let xib = UINib(nibName: xibName, bundle: bundle)
        register(xib, forCellWithReuseIdentifier: xibName)
    }
}
