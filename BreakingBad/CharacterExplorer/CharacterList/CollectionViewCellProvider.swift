//
//  CollectionViewCellProvider.swift
//  BreakingBad
//
//  Created by Anderson Costa on 12/01/2021.
//

import UIKit

public protocol CollectionViewCell {
    associatedtype ViewModel

    func bind(to: ViewModel)
}

public protocol CollectionViewInteractor: AnyObject {
    func selectItem(atIndex: Int)
}

class CollectionViewCellProvider<Cell: UICollectionViewCell, ViewModel>: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, CollectionViewDataProvider where Cell: CollectionViewCell, ViewModel == Cell.ViewModel {

    private let interactor: CollectionViewInteractor
    private var viewModels: [ViewModel] = []
    private var view: UICollectionView?

    init(interactor: CollectionViewInteractor) {
        self.interactor = interactor
    }

    func bind(to view: UICollectionView) {
        self.view = view
        view.dataSource = self
        view.delegate = self
    }

    func updateViewModels(_ viewModels: [ViewModel]) {
        self.viewModels = viewModels
        DispatchQueue.main.async {
            self.view?.reloadData()
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(ofType: Cell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        let viewModel = viewModels[indexPath.row]
        cell.bind(to: viewModel)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        interactor.selectItem(atIndex: indexPath.row)
    }
}

private extension UICollectionView {

    func dequeueReusableCell<T: UICollectionViewCell>(ofType: T.Type, for indexPath: IndexPath) -> T? {
        let reuseIdentifier = String(describing: T.self)
        return dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T
    }
}
