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
    private var viewModel: SliderViewModel!
    private lazy var dataSource: RxTableViewSectionedReloadDataSource<SliderSettingListSectionModel> =
    viewModel.sliderSettingListDataSource()
    
    static func create(
        _ viewModel: SliderViewModel,
        _ coordinator: SliderCoordinatorProtocol
    ) -> SliderViewController {
        let viewController = SliderViewController()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        viewController.bind()
        return viewController
    }
    
    lazy var targetSlider: UISlider = UISlider().then { slier in
        slier.maximumValue = SliderViewControllerConstants.targetMaximumValue
        slier.minimumValue = SliderViewControllerConstants.targetMinimumValue
    }
    
    @objc override func didTappedLeftBarButton() { coordinator?.finish() }
    
    func bind() {
        settingList.rx.setDelegate(self)
        
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
    }
    
    override func attribute() {
        super.attribute()
        navigationItem.title = SliderViewControllerConstants.title
        targetSlider.setValue(SliderViewControllerConstants.targetValue, animated: true)
    }
    
    override func layout() {
        super.layout()
        
        containerView.addSubview(targetSlider)
        
        targetSlider.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview().inset(SliderViewControllerConstants.defaultOffset)
            
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
    
    deinit {
        print("SliderViewController Deinit")
    }
    
}

extension SliderViewController: UITableViewDelegate {
    
}

extension Reactive where Base: SliderViewController {
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
