//
//  SliderViewModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

protocol SliderViewModelProtocol {
    // value
    var maximumValueDidChanged: BehaviorRelay<Float> { get }
    var minimumValueDidChanged: BehaviorRelay<Float> { get }
    
    // color
    var thumbTintColor: BehaviorRelay<UIColor?> { get }
    var maximumTrackTintColor: BehaviorRelay<UIColor?> { get }
    var minimumTrackTintColor: BehaviorRelay<UIColor?> { get }
    var tintColor: BehaviorRelay<UIColor> { get }
    var backgroundColor: BehaviorRelay<UIColor?> { get }
    
    var sliderSettingCodeText: BehaviorRelay<String> { get }
    
    // ViewModel -> View
    var sliderSettingListCellDatas: Driver<[SliderSettingListSectionModel]> { get }
    
    var codeCellCodeLabelText: Driver<String> { get }
    
    // value
    var targetMaximumValue: Driver<Float> { get }
    var targetMinimumValue: Driver<Float> { get }
    
    // color
    var targetThumbTintColor: Driver<UIColor?> { get }
    var targetMaximumTrackTintColor: Driver<UIColor?> { get }
    var targetMinimumTrackTintColor: Driver<UIColor?> { get }
    var targetTintColor: Driver<UIColor> { get }
    var targetBackgroundColor: Driver<UIColor?> { get }
    
    func sliderSettingListDataSource() -> RxTableViewSectionedReloadDataSource<SliderSettingListSectionModel>
    func sliderSettingToCode()
    func valueCellDidChanged(_ sliderValue: SliderValue)
    func colorCellDidSelected(_ sliderColor: SliderColor)
}

final class SliderViewModel: SliderViewModelProtocol {
    
    private let disposebag = DisposeBag()
    
    // View -> ViewModel
    
    // value
    let maximumValueDidChanged = BehaviorRelay<Float>(value: SliderViewControllerConstants.targetMaximumValue)
    let minimumValueDidChanged = BehaviorRelay<Float>(value: SliderViewControllerConstants.targetMinimumValue)
    
    // color
    let thumbTintColor = BehaviorRelay<UIColor?>(value: nil)
    let maximumTrackTintColor = BehaviorRelay<UIColor?>(value: nil)
    let minimumTrackTintColor = BehaviorRelay<UIColor?>(value: nil)
    let tintColor = BehaviorRelay<UIColor>(value: .tintColor)
    let backgroundColor = BehaviorRelay<UIColor?>(value: nil)
    
    let sliderSettingCodeText = BehaviorRelay<String>(value: SliderViewControllerConstants.defaultSliderCode)
    
    // ViewModel -> View
    let sliderSettingListCellDatas: Driver<[SliderSettingListSectionModel]>
    
    let codeCellCodeLabelText: Driver<String>
    
    // value
    let targetMaximumValue: Driver<Float>
    let targetMinimumValue: Driver<Float>
    
    // color
    let targetThumbTintColor: Driver<UIColor?>
    let targetMaximumTrackTintColor: Driver<UIColor?>
    let targetMinimumTrackTintColor: Driver<UIColor?>
    let targetTintColor: Driver<UIColor>
    let targetBackgroundColor: Driver<UIColor?>
    
    init() {
        sliderSettingListCellDatas = Observable.just(SliderSettingListData.settingListDatas).asDriver(onErrorDriveWith: .empty())
        
        codeCellCodeLabelText = sliderSettingCodeText
            .asDriver(onErrorDriveWith: .empty())
        
        targetMaximumValue = maximumValueDidChanged
            .asDriver(onErrorDriveWith: .empty())
        
        targetMinimumValue = minimumValueDidChanged
            .asDriver(onErrorDriveWith: .empty())
        
        targetTintColor = tintColor.asDriver()
        targetBackgroundColor = backgroundColor.asDriver()
        targetMaximumTrackTintColor = maximumTrackTintColor.asDriver()
        targetMinimumTrackTintColor = minimumTrackTintColor.asDriver()
        targetThumbTintColor = thumbTintColor.asDriver()
        
        sliderSettingToCode()
    }
    
    deinit {
        print("SliderViewModel Deinit")
    }
}

extension SliderViewModel {
    func sliderSettingListDataSource() -> RxTableViewSectionedReloadDataSource<SliderSettingListSectionModel> {
        RxTableViewSectionedReloadDataSource<SliderSettingListSectionModel> { dataSource, tableView, indexPath, sectionModelItem in
            SliderModel.makeCell(
                dataSource[indexPath.section].sectionHeader,
                self,
                tableView,
                indexPath,
                sectionModelItem
            )
        }
    }
    
    func sliderSettingToCode() {
        Observable.combineLatest(
            maximumValueDidChanged,
            minimumValueDidChanged,
            tintColor,
            backgroundColor,
            thumbTintColor,
            maximumTrackTintColor,
            minimumTrackTintColor
        ).map(SliderModel.codeLabelText)
            .bind(to: sliderSettingCodeText)
            .disposed(by: disposebag)
    }
    
    
    func valueCellDidChanged(_ sliderValue: SliderValue) {
        switch sliderValue.valueType {
        case .maximum:
            maximumValueDidChanged.accept(sliderValue.value)
        case .minimum:
            minimumValueDidChanged.accept(sliderValue.value)
        }
    }
    
    func colorCellDidSelected(_ sliderColor: SliderColor) {
        switch sliderColor.colorType {
        case .tint:
            tintColor.accept(sliderColor.color)
        case .background:
            backgroundColor.accept(sliderColor.color)
        case .maximumTrackTintColor:
            maximumTrackTintColor.accept(sliderColor.color)
        case .minimumTrackTintColor:
            minimumTrackTintColor.accept(sliderColor.color)
        case .thumbTint:
            thumbTintColor.accept(sliderColor.color)
        }
    }
}
