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
 
final class SliderViewModel {
    
    let disposebag = DisposeBag()
    
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
    
    func valueCellDidChanged(_ sliderValue: SliderValue) {
        switch sliderValue.valueType {
        case .maximum:
            maximumValueDidChanged.accept(sliderValue.value)
        case .minimum:
            minimumValueDidChanged.accept(sliderValue.value)
        }
    }

    deinit {
        print("SliderViewModel Deinit")
    }
}

extension SliderViewModel {
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
