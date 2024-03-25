//
//  LabelViewController.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class LabelViewController: DefaultListViewController {
    
    private weak var coordinator: LabelCoordinatorProtocol?
    private var viewModel: LabelViewModelProtocol!
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<LabelSettingListSectionModel> = viewModel.labelSettingListDataSource()
    
    static func create(
        _ coordinator: LabelCoordinatorProtocol,
        _ viewModel: LabelViewModelProtocol
    ) -> LabelViewController {
        let viewController = LabelViewController()
        viewController.coordinator = coordinator
        viewController.viewModel = viewModel
        viewController.bind()
        return viewController
    }
    
    // MARK: - UI구현
    lazy var targetLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = LabelViewControllerConstants.title
        label.font = LabelViewControllerConstants.targetLabelFont
        label.numberOfLines = LabelViewControllerConstants.targetLabelNumberOfLines
        label.clipsToBounds = true
        label.layer.cornerRadius = LabelViewControllerConstants.targetLabelCornerRadius
        label.textAlignment = .center
        label.backgroundColor = .systemBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
            
    // MARK: - 라이프사이클
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.finish()
    }
    
    // MARK: - 바인딩
    private func bind() {
        viewModel.labelSettingListCellDatas
            .drive(settingList.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        settingList.rx.itemSelected
            .compactMap { [weak dataSource] indexPath -> LabelSettingListItemType? in
                guard let dataSource = dataSource else { return nil }
                return dataSource[indexPath.section].items[indexPath.row]
            }
            .bind(onNext: viewModel.labelSettingListItemSelected)
            .disposed(by: disposeBag)
        
        settingList
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.targetText
            .drive(self.rx.targetText)
            .disposed(by: disposeBag)
        
        viewModel.targetFont
            .drive(self.rx.targetFont)
            .disposed(by: disposeBag)
        
        viewModel.targetTitleColor
            .drive(self.rx.targetTitleColor)
            .disposed(by: disposeBag)
        
        viewModel.targetBackgroundColor
            .drive(self.rx.targetBackgroundColor)
            .disposed(by: disposeBag)
        
        viewModel.targetAlignment
            .drive(self.rx.targetAlignment)
            .disposed(by: disposeBag)
        
        viewModel.targetNumberOfLines
            .drive(self.rx.targetNumberOfLines)
            .disposed(by: disposeBag)
    }
    
    // MARK: - 레이아웃
    override func attribute() {
        super.attribute()
        navigationItem.title = LabelViewControllerConstants.title
    }
    
    override func layout() {
        super.layout()
        containerView.addSubview(targetLabel)
        
        NSLayoutConstraint.activate([
            targetLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: LabelViewControllerConstants.targetLabelOffset),
            targetLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: LabelViewControllerConstants.targetLabelOffset),
            targetLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -LabelViewControllerConstants.targetLabelOffset),
            targetLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -LabelViewControllerConstants.targetLabelOffset)
        ])
    }
    
    override func getDocumentURLString() -> String {
        LabelViewControllerConstants.documentURLString
    }
    
    @objc override func didTappedLeftBarButton() {
        coordinator?.finish()
    }
    
    override func settingListConfigure() {
        super.settingListConfigure()
        LabelCodeCell.register(tableView: settingList)
        LabelTextCell.register(tableView: settingList)
        LabelFontCell.register(tableView: settingList)
        LabelFontSizeCell.register(tableView: settingList)
        LabelColorCell.register(tableView: settingList)
        LabelAlignmentCell.register(tableView: settingList)
        LabelNumberOfLinesCell.register(tableView: settingList)
    }

}

// MARK: - UITableViewDelegate
extension LabelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DefaultSettingListHeaderView()
        headerView.setupHeaderTitle(dataSource[section].sectionHeader.rawValue)
        return headerView
    }
}

// MARK: - Reactive
extension Reactive where Base: LabelViewController {
    
    var targetText: Binder<String> {
        return Binder(base) { base, text in
            base.targetLabel.text = text
        }
    }
    
    var targetFont: Binder<UIFont> {
        return Binder(base) { base, font in
            base.targetLabel.font = font
        }
    }
    
    var targetTitleColor: Binder<UIColor> {
        return Binder(base) { base, color in
            base.targetLabel.textColor = color
        }
    }
    
    var targetBackgroundColor: Binder<UIColor> {
        return Binder(base) { base, color in
            base.targetLabel.backgroundColor = color
        }
    }
    
    var targetAlignment: Binder<ObjectAlignmentType> {
        return Binder(base) { base, alignment in
            base.targetLabel.textAlignment = alignment.aligment
        }
    }
    
    var targetNumberOfLines: Binder<Int> {
        return Binder(base) { base, numberOfLines in
            base.targetLabel.numberOfLines = numberOfLines
        }
    }
    
}
