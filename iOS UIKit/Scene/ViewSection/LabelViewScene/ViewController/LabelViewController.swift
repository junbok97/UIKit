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
    private var viewModel: LabelViewModel!
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<LabelSettingListSectionModel> = viewModel.labelSettingListDataSource()
    
    static func create(
        _ viewModel: LabelViewModel,
        _ coordinator: LabelCoordinatorProtocol
    ) -> LabelViewController {
        let viewController = LabelViewController()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        viewController.bind()
        return viewController
    }
    
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
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.finish()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func bind() {
        viewModel.labelSettingListCellDatas
            .drive(settingList.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        settingList.rx.itemSelected
            .compactMap { [weak dataSource] indexPath -> LabelSettingListSectionItemType? in
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
    
    deinit {
        print("LabelViewController Deinit")
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

extension LabelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DefaultSettingListHeaderView()
        headerView.setupHeaderTitle(dataSource[section].sectionHeader.rawValue)
        return headerView
    }
    
//    func tableView(_: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt _: IndexPath) {
//        guard let cell = cell as? DefaultCell else { return }
//        cell.disposeBag = DisposeBag()
//    }

}
