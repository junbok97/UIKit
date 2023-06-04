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
    
    var axisDidSelected: BehaviorRelay<StackViewAxisType> { get }
    var spacingDidChanged: BehaviorRelay<CGFloat> { get }
    var alignmentDidSelected: BehaviorRelay<StackViewAlignmentType> { get }
    var distributionDidSelected: BehaviorRelay<StackViewDistributionType> { get }
    var tintColorDidSelected: BehaviorRelay<UIColor?> { get }
    var backgroundColorDidSelected: BehaviorRelay<UIColor?> { get }
    
    var stackViewSettingCodeText: BehaviorRelay<String> { get }
    
    var stackViewSettingListCellDatas: Driver<[StackViewSettingListSectionModel]> { get }
    var codeCellCodeLabelText: Driver<String> { get }
    var targetTintColor: Driver<UIColor?> { get }
    var targetBackgroundColor: Driver<UIColor?> { get }
    var targetSpacing: Driver<CGFloat> { get }
    var targetAxis: Driver<StackViewAxisType> { get }
    var targetAlignment: Driver<StackViewAlignmentType> { get }
    var targetDistribution: Driver<StackViewDistributionType> { get }
    
    func stackViewSettingListDataSource() -> RxTableViewSectionedReloadDataSource<StackViewSettingListSectionModel>
    func spacingCellDidChanged(_ spacing: CGFloat)
    func colorCellDidSelected(_ stackViewColor: StackViewColor)
    func stackViewSettingToCode()
    func stackViewSettingListItemSelected(_ type: StackViewSettingListItemType)
}

final class StackViewViewModel: StackViewViewModelProtocol {

    private let disposeBag = DisposeBag()
    
    let stackViewSettingCodeText = BehaviorRelay<String>(value: StackViewCodeCellConstants.defaultLabelCode)
    let axisDidSelected = BehaviorRelay<StackViewAxisType>(value: StackViewControllerConstants.targetAxis)
    let spacingDidChanged = BehaviorRelay<CGFloat>(value: StackViewControllerConstants.targetSpacing)
    let alignmentDidSelected = BehaviorRelay<StackViewAlignmentType>(value: StackViewControllerConstants.targetAlignment)
    let distributionDidSelected = BehaviorRelay<StackViewDistributionType>(value: StackViewControllerConstants.targetDistribution)
    
    let tintColorDidSelected = BehaviorRelay<UIColor?>(value: nil)
    let backgroundColorDidSelected = BehaviorRelay<UIColor?>(value: nil)
    
    let stackViewSettingListCellDatas: Driver<[StackViewSettingListSectionModel]>
    let codeCellCodeLabelText: Driver<String>
    let targetTintColor: Driver<UIColor?>
    let targetBackgroundColor: Driver<UIColor?>
    let targetSpacing: Driver<CGFloat>
    let targetAxis: Driver<StackViewAxisType>
    let targetAlignment: Driver<StackViewAlignmentType>
    let targetDistribution: Driver<StackViewDistributionType>
    
    init() {

        stackViewSettingListCellDatas = Observable.just(StackViewSettingListData.settingListDatas).asDriver(onErrorDriveWith: .empty())
        
        codeCellCodeLabelText = stackViewSettingCodeText
            .asDriver(onErrorDriveWith: .empty())
        
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
        
        stackViewSettingToCode()
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
    
    func stackViewSettingToCode() {
        Observable
            .combineLatest(
                axisDidSelected,
                spacingDidChanged,
                alignmentDidSelected,
                distributionDidSelected,
                tintColorDidSelected,
                backgroundColorDidSelected
            ).map(StackViewModel.codeLabelText)
            .bind(to: stackViewSettingCodeText)
            .disposed(by: disposeBag)
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
            axisDidSelected.accept(type)
        case .alignment(let type):
            alignmentDidSelected.accept(type)
        case .distribution(let type):
            distributionDidSelected.accept(type)
        default:
            return
        }
    }
    
}


final class StackViewViewModel2 {
    
    struct StackViewConfigure {
        let axis: StackViewAxisType
        let spacing: CGFloat
        let alignment: StackViewAlignmentType
        let distribution: StackViewDistributionType
        let tintColor: UIColor?
        let backgroundColor: UIColor?
    }
    
    private let disposeBag = DisposeBag()
        
    private var axis: StackViewAxisType = StackViewControllerConstants.targetAxis
    private var spacing: CGFloat = StackViewControllerConstants.targetSpacing
    private var alignment: StackViewAlignmentType = StackViewControllerConstants.targetAlignment
    private var distribution: StackViewDistributionType = StackViewControllerConstants.targetDistribution
    private var tintColor: UIColor? = nil
    private var backgroundColor: UIColor? = nil
    
    private let targetConfigureStream = PublishRelay<StackViewConfigure>()
    private let codeCellStream = PublishRelay<String>()
    
    let targetConfigure: Driver<StackViewConfigure>
    let codeCellText: Driver<String>
    
    init() {
        targetConfigure = targetConfigureStream
            .asDriver(onErrorDriveWith: .empty())
        codeCellText = codeCellStream
            .asDriver(onErrorDriveWith: .empty())
    }
    
    func setTargetAxis(_ axis: StackViewAxisType) {
        self.axis = axis
        updateTarget()
    }
    
    func setTargetSpacing(_ spacing: CGFloat) {
        self.spacing = spacing
        updateTarget()
    }
    
    func setTargetAlignmet(_ alignmnet: StackViewAlignmentType) {
        self.alignment = alignmnet
        updateTarget()
    }
    
    func setTargetDistribution(_ distribution: StackViewDistributionType) {
        self.distribution = distribution
        updateTarget()
    }
    
    func setTargetTintColor(_ tintColor: UIColor?) {
        self.tintColor = tintColor
        updateTarget()
    }
    
    func setTargetBackgroundColor(_ backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        updateTarget()
    }
    
    func updateTarget() {
        let configure = StackViewConfigure(
            axis: axis,
            spacing: spacing,
            alignment: alignment,
            distribution: distribution,
            tintColor: tintColor,
            backgroundColor: backgroundColor
        )
        codeCellStream.accept(StackViewModel.codeToString(configure))
        targetConfigureStream.accept(configure)
    }

}
