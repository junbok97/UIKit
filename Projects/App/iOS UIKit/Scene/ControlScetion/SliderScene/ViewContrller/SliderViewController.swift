//
//  SliderViewContrller.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import SnapKit
import Then

final class SliderViewController: DefaultListViewController {
    weak var coordinator: SliderCoordinatorProtocol?
    private var viewModel: SliderViewModelProtocol!
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<SliderSettingListSectionModel> =
    viewModel.sliderSettingListDataSource()
    
    static func create(
        _ coordinator: SliderCoordinatorProtocol,
        _ viewModel: SliderViewModelProtocol
    ) -> SliderViewController {
        let viewController = SliderViewController()
        viewController.coordinator = coordinator
        viewController.viewModel = viewModel
        viewController.bind()
        return viewController
    }
    
    // MARK: - UI구현
    lazy var targetSliderValueLabel: UILabel = {
        let label = UILabel()
        label.text = SliderViewControllerConstants.sliderValueLabelText
        label.font = SliderViewControllerConstants.defaultFont
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    lazy var targetSlider: UISlider = UISlider().then { slider in
        slider.maximumValue = SliderViewControllerConstants.targetMaximumValue
        slider.minimumValue = SliderViewControllerConstants.targetMinimumValue
    }

    @objc override func didTappedLeftBarButton() { coordinator?.finish() }
    
    
    // MARK: - 바인딩
    private func bind() {
        targetSlider.setValue(SliderViewControllerConstants.targetValue, animated: true)
        settingList.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.sliderSettingListCellDatas
            .drive(settingList.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        viewModel.targetTintColor
            .drive(self.rx.targetTintColor)
            .disposed(by: disposeBag)
        
        viewModel.targetBackgroundColor
            .drive(self.rx.targetBackgroundColor)
            .disposed(by: disposeBag)
        
        viewModel.targetThumbTintColor
            .drive(self.rx.targetThumbTintColor)
            .disposed(by: disposeBag)
        
        viewModel.targetMaximumTrackTintColor
            .drive(self.rx.targetMaxTrackColor)
            .disposed(by: disposeBag)
        
        viewModel.targetMinimumTrackTintColor
            .drive(self.rx.targetMinTrackColor)
            .disposed(by: disposeBag)
        
        viewModel.targetMaximumValue
            .drive(self.targetSlider.rx.maximumValue)
            .disposed(by: disposeBag)

        viewModel.targetMinimumValue
            .drive(self.targetSlider.rx.minimumValue)
            .disposed(by: disposeBag)
        
        targetSlider.rx.value
            .bind(to: self.rx.targetSliderValueLabel)
            .disposed(by: disposeBag)
    }
    
    // MARK: - 레이아웃
    override func attribute() {
        super.attribute()
        navigationItem.title = SliderViewControllerConstants.title
    }
    
    override func layout() {
        super.layout()
        [targetSlider, targetSliderValueLabel].forEach {
            containerView.addSubview($0)
        }
        
        targetSlider.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(SliderViewControllerConstants.defaultOffset)
            make.centerY.equalToSuperview()
        }
        
        targetSliderValueLabel.snp.makeConstraints { make in
            make.bottom.equalTo(targetSlider.snp.top).offset(SliderViewControllerConstants.defaultOffset)
            make.leading.trailing.top.equalToSuperview().inset(SliderViewControllerConstants.defaultOffset)
        }
    }
    
    override func getDocumentURLString() -> String {
        SliderViewControllerConstants.documentURLString
    }
    
    override func settingListConfigure() {
        super.settingListConfigure()
        SliderColorCell.register(tableView: settingList)
        SliderValueCell.register(tableView: settingList)
        SliderCodeCell.register(tableView: settingList)
        SliderImageCell.register(tableView: settingList)
    }
    
}

// MARK: - UITableViewDelegate
extension SliderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DefaultSettingListHeaderView()
        headerView.setupHeaderTitle(dataSource[section].sectionHeader.rawValue)
        return headerView
    }
}

// MARK: - Reactive
extension Reactive where Base: SliderViewController {
    var targetSliderValueLabel: Binder<Float> {
        Binder(base) { base, value in
            base.targetSliderValueLabel.text = String(format: "%lf", value)
        }
    }
    
    var targetTintColor: Binder<UIColor> {
        Binder(base) { base, color in
            base.targetSlider.tintColor = color
        }
    }
    
    var targetThumbTintColor: Binder<UIColor?> {
        Binder(base) { base, color in
            base.targetSlider.thumbTintColor = color
        }
    }
    
    var targetBackgroundColor: Binder<UIColor?> {
        Binder(base) { base, color in
            base.targetSlider.backgroundColor = color
        }
    }
    
    var targetMaxTrackColor: Binder<UIColor?> {
        Binder(base) { base, color in
            base.targetSlider.maximumTrackTintColor = color
        }
    }
    
    var targetMinTrackColor: Binder<UIColor?> {
        Binder(base) { base, color in
            base.targetSlider.minimumTrackTintColor = color
        }
    }

}
