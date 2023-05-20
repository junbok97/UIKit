//
//  ButtonViewController.swift
//  UIKit Test
//
//  Created by 이준복 on 2023/05/08.
//

import UIKit
import RxSwift
import RxDataSources

final class ButtonViewController: DefaultListViewController {
    
    weak var coordinator: ButtonCoordinatorProtocol?
    var viewModel: ButtonViewModel!
    private var dataSource: RxTableViewSectionedReloadDataSource<ButtonSettingListSectionModel>!
    
    static func create(
        _ viewModel: ButtonViewModel,
        _ coordinator: ButtonCoordinatorProtocol
    ) -> ButtonViewController {
        let viewController = ButtonViewController()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        viewController.bind()
        return viewController
    }
    
    lazy var targetButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc override func didTappedLeftBarButton() {
        coordinator?.finish()
    }
    
    private func bind() {
        let dataSource = viewModel.buttonSettingListDataSource()
        self.dataSource = dataSource
        
        viewModel.buttonSettingListCellDatas
            .drive(settingList.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        settingList
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.targetButtonConfiguration
            .drive(self.rx.targetButtonConfigureation)
            .disposed(by: disposeBag)
        
        viewModel.targetTintColor
            .drive(self.rx.targetTintColor)
            .disposed(by: disposeBag)
        
    }
    
    override func attribute() {
        super.attribute()
        navigationItem.title = ButtonViewControllerConstants.title
        navigationItem.largeTitleDisplayMode = .never
        settingListConfigure()
    }
    
    override func layout() {
        super.layout()
        containerView.addSubview(targetButton)
    
        NSLayoutConstraint.activate([
            targetButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: ButtonViewControllerConstants.targetButtonVerticalOffset),
            targetButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: ButtonViewControllerConstants.targetButtonHorizonOffset),
            targetButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -ButtonViewControllerConstants.targetButtonHorizonOffset),
            targetButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -ButtonViewControllerConstants.targetButtonVerticalOffset)
        ])
    }
        
    deinit {
        print("ButtonViewController Deinit")
    }
    
}

private extension ButtonViewController {
    func settingListConfigure() {
        ButtonCodeCell.register(tableView: settingList)
        ButtonFontCell.register(tableView: settingList)
        ButtonColorCell.register(tableView: settingList)
        ButtonImageCell.register(tableView: settingList)
        ButtonLabelCell.register(tableView: settingList)
        DefaultSettingListHeaderView.register(tableView: settingList)
        ButtonTextCell.register(tableView: settingList)
        ButtonFontSizeCell.register(tableView: settingList)
    }
}

extension ButtonViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DefaultSettingListHeaderView()
        headerView.setupHeaderTitle(dataSource[section].sectionHeader.rawValue)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if case .image = dataSource[indexPath.section].items[indexPath.row] {
            coordinator?.showSFSymbolsScene()
        } else {
            viewModel.buttonSettingListItemSelected(dataSource[indexPath.section].items[indexPath.row])
        }
        
    }
}

extension Reactive where Base: ButtonViewController {
    var targetTintColor: Binder<UIColor> {
        return Binder(base) { base, tintColor in
            base.targetButton.tintColor = tintColor
        }
    }
    
    var targetButtonConfigureation: Binder<UIButton.Configuration> {
        return Binder(base) { base, configuration in
            base.targetButton.configuration = configuration
        }
    }

}
