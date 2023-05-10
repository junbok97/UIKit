//
//  SFSymbolsViewController.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import UIKit
import RxSwift

final class SFSymbolsViewController: UIViewController {

    weak var coordinator: SFSymbolsCoordinatorProtocol?
    
    private let disposeBag = DisposeBag()
    private var viewModel: SFSymbolsViewModel!
    
    static func create(
        _ viewModel: SFSymbolsViewModel,
        _ coordinator: SFSymbolsCoordinator
    ) -> SFSymbolsViewController {
        let sfSymbolsViewController = SFSymbolsViewController()
        sfSymbolsViewController.viewModel = viewModel
        sfSymbolsViewController.coordinator = coordinator
        sfSymbolsViewController.bind()
        return sfSymbolsViewController
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        SFSymbolsCollectionViewCell.register(target: collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.finish()
    }
    
    func bind() {
        searchController.searchBar.rx.text
            .compactMap { $0 }
            .bind(to: viewModel.serachSFSymbol)
            .disposed(by: disposeBag)
        
        viewModel.symbolListDriver
            .drive(collectionView.rx.items(cellIdentifier: SFSymbolsCollectionViewCell.cellId, cellType: SFSymbolsCollectionViewCell.self)) { _, item, cell in
                cell.setup(item)
            }
            .disposed(by: disposeBag)
        
    }
    
}

private extension SFSymbolsViewController {
    func attribute() {
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = SFSymbolsViewControllerConstants.title
        navigationItem.searchController = searchController
    }
    
    func layout() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func collectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: SFSymbolsViewControllerConstants.itemSizeWidth,
            heightDimension: SFSymbolsViewControllerConstants.itemSizeHeight
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: SFSymbolsViewControllerConstants.groupSizeWidth,
            heightDimension: SFSymbolsViewControllerConstants.groupSizeHeight
        )
        let group = NSCollectionLayoutGroup
            .horizontal(
                layoutSize: groupSize,
                subitem: item,
                count: SFSymbolsViewControllerConstants.groupItemCount
            )
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
}
