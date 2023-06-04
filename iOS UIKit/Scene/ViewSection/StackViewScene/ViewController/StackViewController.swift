//
//  StackViewController.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

final class StackViewController: DefaultListViewController {
    
    private weak var coordinator: StackViewCoordinatorProtocol?
    private var viewModel: StackViewViewModelProtocol!
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<StackViewSettingListSectionModel> = viewModel.stackViewSettingListDataSource()
    
    static func create(
        _ coordinator: StackViewCoordinatorProtocol,
        _ viewModel: StackViewViewModelProtocol
    ) -> StackViewController {
        let viewController = StackViewController()
        viewController.coordinator = coordinator
        viewController.viewModel = viewModel
        viewController.bind()
        return viewController
    }
    
    // MARK: - UI구현
    private lazy var firstObject: UILabel = UILabel().then { label in
        label.textAlignment = .center
        label.font = StackViewControllerConstants.objectFontSize
        label.text = StackViewControllerConstants.firstObjectTitle
        label.backgroundColor = StackViewControllerConstants.firstObjectBackgroundColor
    }

    private lazy var secondObject: UILabel = UILabel().then { label in
        label.textAlignment = .center
        label.font = StackViewControllerConstants.objectFontSize
        label.text = StackViewControllerConstants.secondObjectTitle
        label.backgroundColor = StackViewControllerConstants.secondObjectBackgroundColor
    }
                                                            
    private lazy var thirdObject: UILabel = UILabel().then { label in
        label.textAlignment = .center
        label.font = StackViewControllerConstants.objectFontSize
        label.text = StackViewControllerConstants.thirdObjectTitle
        label.backgroundColor = StackViewControllerConstants.thirdObjectBackgroundColor
    }
    
    private lazy var arrangedSubviews: [UIView] = [firstObject, secondObject, thirdObject]
    
    lazy var targetStackView: UIStackView = UIStackView(arrangedSubviews: arrangedSubviews).then { stackView in
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = StackViewControllerConstants.targetSpacing
    }
    
    // MARK: - 라이프사이클
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.finish()
    }
    
    // MARK: - 바인딩
    private func bind() {
        settingList
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.stackViewSettingListCellDatas
            .drive(settingList.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        settingList.rx.itemSelected
            .subscribe(onNext: {
                print("itemSelected", $0)
            })
            .disposed(by: disposeBag)
        
        settingList.rx.itemSelected
            .compactMap { [weak dataSource] indexPath -> StackViewSettingListItemType? in
                guard let dataSource = dataSource else { return nil }
                return dataSource[indexPath.section].items[indexPath.row]
            }
            .bind(onNext: viewModel.stackViewSettingListItemSelected)
            .disposed(by: disposeBag)
        
        viewModel.targetAxis
            .drive(self.rx.targetAxis)
            .disposed(by: disposeBag)
        
        viewModel.targetSpacing
            .drive(self.rx.targetSpacing)
            .disposed(by: disposeBag)
        
        viewModel.targetAlignment
            .drive(self.rx.targetAlignment)
            .disposed(by: disposeBag)
        
        viewModel.targetDistribution
            .drive(self.rx.targetDistribution)
            .disposed(by: disposeBag)
        
        viewModel.targetTintColor
            .drive(self.rx.targetTintColor)
            .disposed(by: disposeBag)
        
        viewModel.targetBackgroundColor
            .drive(self.rx.targetBackgroundColor)
            .disposed(by: disposeBag)
    }
    
    // MARK: - 레이아웃
    override func attribute() {
        super.attribute()
        navigationItem.title = StackViewControllerConstants.title
    }
    
    override func layout() {
        super.layout()
        containerView.addSubview(targetStackView)
        
        targetStackView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(StackViewControllerConstants.defaultOffset)
        }
    }
    
    override func getDocumentURLString() -> String {
        LabelViewControllerConstants.documentURLString
    }
    
    @objc override func didTappedLeftBarButton() {
        coordinator?.finish()
    }
    
    override func settingListConfigure() {
        super.settingListConfigure()
        StackViewCodeCell.register(tableView: settingList)
        StackViewLabelCell.register(tableView: settingList)
        StackViewColorCell.register(tableView: settingList)
        StackViewSpacingCell.register(tableView: settingList)
    }
        
    deinit {
        print("StackViewController Deinit")
    }

}

// MARK: - UITableViewDelegate
extension StackViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DefaultSettingListHeaderView()
        headerView.setupHeaderTitle(dataSource[section].sectionHeader.rawValue)
        return headerView
    }
}

// MARK: - Reactive
extension Reactive where Base: StackViewController {
    var targetTintColor: Binder<UIColor?> {
        Binder(base) { base, color in
            base.targetStackView.tintColor = color
        }
    }
    
    var targetBackgroundColor: Binder<UIColor?> {
        Binder(base) { base, color in
            base.targetStackView.backgroundColor = color
        }
    }
    
    var targetSpacing: Binder<CGFloat> {
        Binder(base) { base, spacing in
            base.targetStackView.spacing = spacing
        }
    }
    
    var targetAxis: Binder<StackViewAxisType> {
        Binder(base) { base, type in
            base.targetStackView.axis = type.axis
        }
    }
    
    var targetAlignment: Binder<StackViewAlignmentType> {
        Binder(base) { base, type in
            base.targetStackView.alignment = type.alignment
        }
    }
    
    var targetDistribution: Binder<StackViewDistributionType> {
        Binder(base) { base, type in
            base.targetStackView.distribution = type.distribution
        }
    }
}
