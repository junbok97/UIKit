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
    private var viewModel: ButtonViewModel!
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
    
    override func didTappedLeftBarButton() {
        coordinator?.finish()
    }
    
    override func bind() {
        super.bind()
        let dataSource = viewModel.buttonSettingListDataSource()
        self.dataSource = dataSource
        
        viewModel.buttonSettingListCellDatas
            .drive(settingList.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        settingList.rx.itemSelected
            .map { indexPath in
                dataSource[indexPath.section].items[indexPath.row]
            }
            .bind(onNext: viewModel.buttonSettingListItemSelected)
            .disposed(by: disposeBag)
        
        settingList
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.targetButtonConfiguration
            .drive(self.rx.targetConfig)
            .disposed(by: disposeBag)
        
    }
    
    override func attribute() {
        super.attribute()
        navigationItem.title = ButtonViewControllerConstants.title
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
}

extension Reactive where Base: ButtonViewController {
    var targetColor: Binder<ObjectColor> {
        return Binder(base) { base, buttonColor in
            switch buttonColor.colorType {
            case .tintColor:
                base.targetButton.tintColor = buttonColor.color
            default:
                return
            }
        }
    }
    
    var targetConfig: Binder<UIButton.Configuration> {
        return Binder(base) { base, config in
            base.targetButton.configuration = config
        }
    }

}
