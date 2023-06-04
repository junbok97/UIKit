//
//  StackViewModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol StackViewViewModelProtocol: ViewModelProtocol {
    
    var axisDidSelected: BehaviorRelay<NSLayoutConstraint.Axis> { get }
    var spacingDidChanged: BehaviorRelay<CGFloat> { get }
    var alignmentDidSelected: BehaviorRelay<UIStackView.Alignment> { get }
    var distributionDidSelected: BehaviorRelay<UIStackView.Distribution> { get }
    var tintColorDidSelected: BehaviorRelay<UIColor?> { get }
    var backgroundColorDidSelected: BehaviorRelay<UIColor?> { get }
    
    var stackViewSettingListCellDatas: Driver<[StackViewSettingListSectionModel]> { get }
    var codeCellCodeLabelText: Driver<String> { get }
    var targetTintColor: Driver<UIColor?> { get }
    var targetBackgroundColor: Driver<UIColor?> { get }
    var targetSpacing: Driver<CGFloat> { get }
    var targetAxis: Driver<NSLayoutConstraint.Axis> { get }
    var targetAlignment: Driver<UIStackView.Alignment> { get }
    var targetDistribution: Driver<UIStackView.Distribution> { get }
    
    func stackViewSettingListDataSource() -> RxTableViewSectionedReloadDataSource<StackViewSettingListSectionModel>
    func spacingCellDidChanged(_ spacing: CGFloat)
    func colorCellDidSelected(_ stackViewColor: StackViewColor)
    func stackViewSettingListItemSelected(_ type: StackViewSettingListItemType)
}

final class StackViewViewModel: StackViewViewModelProtocol {
    
    let axisDidSelected = BehaviorRelay<NSLayoutConstraint.Axis>(value: StackViewControllerConstants.targetAxis)
    let spacingDidChanged = BehaviorRelay<CGFloat>(value: StackViewControllerConstants.targetSpacing)
    let alignmentDidSelected = BehaviorRelay<UIStackView.Alignment>(value: StackViewControllerConstants.targetAlignment)
    let distributionDidSelected = BehaviorRelay<UIStackView.Distribution>(value: StackViewControllerConstants.targetDistribution)
    
    let tintColorDidSelected = BehaviorRelay<UIColor?>(value: nil)
    let backgroundColorDidSelected = BehaviorRelay<UIColor?>(value: nil)
    
    let stackViewSettingListCellDatas: Driver<[StackViewSettingListSectionModel]>
    let codeCellCodeLabelText: Driver<String>
    let targetTintColor: Driver<UIColor?>
    let targetBackgroundColor: Driver<UIColor?>
    let targetSpacing: Driver<CGFloat>
    let targetAxis: Driver<NSLayoutConstraint.Axis>
    let targetAlignment: Driver<UIStackView.Alignment>
    let targetDistribution: Driver<UIStackView.Distribution>
    
    init() {
        stackViewSettingListCellDatas = Observable.just(StackViewSettingListData.settingListDatas).asDriver(onErrorDriveWith: .empty())
        
        codeCellCodeLabelText = Observable.just("").asDriver(onErrorDriveWith: .empty())
        
        targetTintColor = tintColorDidSelected
            .asDriver(onErrorDriveWith: .empty())
        
        targetBackgroundColor = backgroundColorDidSelected
            .asDriver(onErrorDriveWith: .empty())
        
        targetSpacing = spacingDidChanged
            .asDriver(onErrorDriveWith: .empty())
        
        targetAxis = axisDidSelected
            .asDriver(onErrorDriveWith: .empty())
        
        targetAlignment = alignmentDidSelected
            .asDriver(onErrorDriveWith: .empty())
        
        targetDistribution = distributionDidSelected
            .asDriver(onErrorDriveWith: .empty())
    }
    
}

extension StackViewViewModel {
    func stackViewSettingListDataSource() -> RxTableViewSectionedReloadDataSource<StackViewSettingListSectionModel> {
        RxTableViewSectionedReloadDataSource<StackViewSettingListSectionModel> {  dataSource, tableView, indexPath, sectionModelItem in
            StackViewModel.makeCell(
                dataSource[indexPath.section].sectionHeader,
                self,
                tableView,
                indexPath,
                sectionModelItem
            )
        } // RxTableViewSectionedReloadDataSource
    }
    
    func spacingCellDidChanged(_ spacing: CGFloat) {
        spacingDidChanged.accept(spacing)
    }
    
    func colorCellDidSelected(_ stackViewColor: StackViewColor) {
        switch stackViewColor.colorType {
        case .tintColor:
            tintColorDidSelected.accept(stackViewColor.color)
        case .backgroundColor:
            backgroundColorDidSelected.accept(stackViewColor.color)
        }
    }
    
    func stackViewSettingListItemSelected(_ type: StackViewSettingListItemType) {
        print(#function)
        switch type {
        case .axis(let type):
            axisDidSelected.accept(type.axis)
        case .alignment(let type):
            alignmentDidSelected.accept(type.alignment)
        case .distribution(let type):
            distributionDidSelected.accept(type.distribution)
        default:
            return
        }
    }
    
}
