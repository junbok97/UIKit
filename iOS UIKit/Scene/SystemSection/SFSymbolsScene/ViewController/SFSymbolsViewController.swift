//
//  SFSymbolsViewController.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import UIKit
import RxSwift

final class SFSymbolsViewController: DefaultViewController {

    weak var coordinator: SFSymbolsCoordinatorProtocol?

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
    
    private lazy var sfSymbolsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        SFSymbolsCollectionViewCell.register(target: collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.tintColor = .label
        return searchController
    }()
    
    @objc override func didTappedLeftBarButton() {
        coordinator?.finish()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    private func bind() {
        searchController.searchBar.rx.text
            .compactMap { $0 }
            .bind(onNext: { [weak viewModel] text in
                viewModel?.serachSFSymbolSystemName(text)
            })
            .disposed(by: disposeBag)
        
        viewModel.symbolSystemNameListDriver
            .drive(sfSymbolsCollectionView.rx.items(cellIdentifier: SFSymbolsCollectionViewCell.cellId, cellType: SFSymbolsCollectionViewCell.self)) { _, item, cell in
                cell.setup(item)
            }
            .disposed(by: disposeBag)
        
    }
    
    func bind(_ buttonViewModel: ButtonViewModel) {
        sfSymbolsCollectionView.rx.itemSelected
            .compactMap { [weak self] indexPath -> String? in
                guard let self = self else { return nil }
                return self.viewModel.getSFSymbolsSystemName(indexPath)
            }
            .bind(onNext: buttonViewModel.sfSymbolSeleted)
            .disposed(by: disposeBag)
        
        sfSymbolsCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.coordinator?.finish()
            })
            .disposed(by: disposeBag)
            
    }
    
    override func attribute() {
        super.attribute()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = SFSymbolsViewControllerConstants.title
        navigationItem.searchController = searchController
    }
    
    override func getDocumentURLString() -> String {
        SFSymbolsViewControllerConstants.documentURLString
    }
    
    deinit {
        print("SFSymbolsViewController Deinit")
    }
    
}

private extension SFSymbolsViewController {
    
    func layout() {
        view.addSubview(sfSymbolsCollectionView)
        
        NSLayoutConstraint.activate([
            sfSymbolsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            sfSymbolsCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            sfSymbolsCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            sfSymbolsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
