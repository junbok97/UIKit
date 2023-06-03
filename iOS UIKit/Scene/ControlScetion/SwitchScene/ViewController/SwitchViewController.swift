//
//  SwitchViewController.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class SwitchViewController: DefaultListViewController {
    private weak var coordinator: SwitchCoordinatorProtocol?
    private var viewModel: SwitchViewModelProtocol!
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<SwitchSettingListSectionModel> = viewModel.switchSettingListDataSource()
    
    static func create(
        _ coordinator: SwitchCoordinatorProtocol,
        _ viewModel: SwitchViewModelProtocol
    ) -> SwitchViewController {
        let viewController = SwitchViewController()
        viewController.coordinator = coordinator
        viewController.viewModel = viewModel
        viewController.bind()
        return viewController
    }
    
    // MARK: - UI 구현
    lazy var targetSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = true
        toggle.onTintColor = .systemGreen
        toggle.thumbTintColor = .white
        toggle.backgroundColor = .secondarySystemBackground
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    @objc override func didTappedLeftBarButton() { coordinator?.finish() }
    
    // MARK: - 바인딩
    private func bind() {
        viewModel.switchSettingListcellDatas
            .drive(settingList.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.targetOnTintColor
            .drive(self.rx.targetOnTintColor)
            .disposed(by: disposeBag)
        
        viewModel.targetThumbTintColor
            .drive(self.rx.targetThumbTintColor)
            .disposed(by: disposeBag)
        
        viewModel.targetBackgroundColor
            .drive(self.rx.targetBackgroundColor)
            .disposed(by: disposeBag)
        
        targetSwitch.rx.isOn
            .bind(to: viewModel.isOnDidChanged)
            .disposed(by: disposeBag)
        
        settingList
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    // MARK: - 레이아웃
    override func attribute() {
        super.attribute()
        navigationItem.title = SwitchViewControllerConstants.title
    }
    
    override func layout() {
        super.layout()
        
        containerView.addSubview(targetSwitch)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: SwitchViewControllerConstants.containerViewHeight),
            targetSwitch.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            targetSwitch.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    override func getDocumentURLString() -> String {
        SwitchViewControllerConstants.documentURLString
    }
    
    override func settingListConfigure() {
        super.settingListConfigure()
        SwitchCodeCell.register(tableView: settingList)
        SwitchColorCell.register(tableView: settingList)
    }
    
    deinit {
        print("SwitchViewController Deinit")
    }
}

// MARK: - UITableViewDelegate
extension SwitchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DefaultSettingListHeaderView()
        headerView.setupHeaderTitle(dataSource[section].sectionHeader.rawValue)
        return headerView
    }
}

// MARK: - Reactive
extension Reactive where Base: SwitchViewController {
    var targetOnTintColor: Binder<UIColor> {
        Binder(base) { base, color in
            base.targetSwitch.onTintColor = color
        }
    }
    
    var targetThumbTintColor: Binder<UIColor> {
        Binder(base) { base, color in
            base.targetSwitch.thumbTintColor = color
        }
    }
    
    var targetBackgroundColor: Binder<UIColor> {
        Binder(base) { base, color in
            base.targetSwitch.backgroundColor = color
        }
    }
}
