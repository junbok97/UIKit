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
    func setTargetAxis(_ axis: StackViewAxisType)
    func setTargetSpacing(_ spacing: CGFloat)
    func setTargetAlignmet(_ alignmnet: StackViewAlignmentType)
    func setTargetDistribution(_ distribution: StackViewDistributionType)
    func setTargetTintColor(_ tintColor: UIColor?)
    func setTargetBackgroundColor(_ backgroundColor: UIColor?)
    func updateTarget()
    func colorCellDidSelected(_ stackViewColor: StackViewColor)
    func stackViewSettingListItemSelected(_ type: StackViewSettingListItemType)
    func stackViewSettingListDataSource() -> RxTableViewSectionedReloadDataSource<StackViewSettingListSectionModel>
}

final class StackViewViewModel: StackViewViewModelProtocol {
    
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
    private let codeCellStream = BehaviorRelay<String>(value: StackViewCodeCellConstants.defaultLabelCode)
    
    let targetConfigure: Driver<StackViewConfigure>
    let codeCellText: Driver<String>
    
    init() {
        targetConfigure = targetConfigureStream
            .asDriver(onErrorDriveWith: .empty())
        codeCellText = codeCellStream
            .asDriver(onErrorDriveWith: .empty())
        
        updateTarget()
    }
    
}

extension StackViewViewModel {
    
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
    
    func colorCellDidSelected(_ stackViewColor: StackViewColor) {
        switch stackViewColor.colorType {
        case .tintColor:
            setTargetTintColor(stackViewColor.color)
        case .backgroundColor:
            setTargetBackgroundColor(stackViewColor.color)
        }
    }
    
    func stackViewSettingListItemSelected(_ type: StackViewSettingListItemType) {
        switch type {
        case .axis(let type):
            setTargetAxis(type)
        case .alignment(let type):
            setTargetAlignmet(type)
        case .distribution(let type):
            setTargetDistribution(type)
        default:
            return
        }
    }
    
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

}
