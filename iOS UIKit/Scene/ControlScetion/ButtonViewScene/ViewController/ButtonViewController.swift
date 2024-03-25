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
    
    private weak var coordinator: ButtonCoordinatorProtocol?
    private var viewModel: ButtonViewModelProtocol!
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<ButtonSettingListSectionModel> = viewModel.buttonSettingListDataSource()
    
    static func create(
        _ coordinator: ButtonCoordinatorProtocol,
        _ viewModel: ButtonViewModelProtocol
    ) -> ButtonViewController {
        let viewController = ButtonViewController()
        viewController.coordinator = coordinator
        viewController.viewModel = viewModel
        viewController.bind()
        return viewController
    }
    
    // MARK: - UI구현
    lazy var targetButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc override func didTappedLeftBarButton() {
        coordinator?.finish()
    }
    
    // MARK: - 바인딩
    private func bind() {
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
    
    // MARK: - 레이아웃
    override func attribute() {
        super.attribute()
        navigationItem.title = ButtonViewControllerConstants.title
    }
    
    override func layout() {
        super.layout()
        containerView.addSubview(targetButton)
    
        NSLayoutConstraint.activate([
            targetButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            targetButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    override func getDocumentURLString() -> String {
        ButtonViewControllerConstants.documentURLString
    }
    
    override func settingListConfigure() {
        super.settingListConfigure()
        ButtonCodeCell.register(tableView: settingList)
        ButtonFontCell.register(tableView: settingList)
        ButtonColorCell.register(tableView: settingList)
        ButtonImageCell.register(tableView: settingList)
        ButtonLabelCell.register(tableView: settingList)
        ButtonTextCell.register(tableView: settingList)
        ButtonFontSizeCell.register(tableView: settingList)
    }
        
    deinit {
        settingList = UITableView()
    }
}

// MARK: - UITableViewDelegate
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
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? DefaultCell else { return }
        cell.disposeBag = DisposeBag()
    }
}

// MARK: - Reactive
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
