//
//  LabelViewModel.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/13.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class LabelViewModel {
    
    private let disposeBag = DisposeBag()
    
    // View -> ViewModel
    let textCellDidChangedTextField = BehaviorRelay<String>(value: LabelViewControllerConstants.title)
    
    let titleColorDidSelected = BehaviorRelay<UIColor>(value: .label)
    let backgroundColorDidSelected = BehaviorRelay<UIColor>(value: .systemBackground)
    
    let fontCellDidSelected = BehaviorRelay<ObjectFontType>(value: .regular)
    let fontSizeCellDidChangedFontSizeSlider = BehaviorRelay<Int>(value: LabelViewControllerConstants.targetLabelFontSize)
    let fontDidSelected = BehaviorRelay<UIFont>(value: LabelViewControllerConstants.targetLabelFont)

    let alignmentCellDidSelected = BehaviorRelay<ObjectAlignmentType>(value: .center)
    let numberOfLinesCellDidChangedLineStepper = BehaviorRelay<Int>(value: LabelViewControllerConstants.targetLabelNumberOfLines)
    
    let didItemSelectedLabelSettingList = PublishRelay<LabelSettingListItemType>()
    
    // ViewModel -> View
    let codeCellCodeLabelText: Driver<String>
    let numberOfLinesCellStepperValueLabelText: Driver<Int>
    let targetText: Driver<String>
    let targetFont: Driver<UIFont>
    let targetTitleColor: Driver<UIColor>
    let targetBackgroundColor: Driver<UIColor>
    let targetAlignment: Driver<ObjectAlignmentType>
    let targetNumberOfLines: Driver<Int>
    let labelSettingListCellDatas: Driver<[LabelSettingListSectionModel]>
    
    let labelSettingCodeText = BehaviorRelay<String>(value: LabelViewControllerConstants.defaultLabelCode)
    
    private let labelModel = LabelModel()
    
    init() {
        
        labelSettingListCellDatas = labelModel.labelSettingListCellDatas
            .asDriver(onErrorDriveWith: .empty())

        targetText = textCellDidChangedTextField
            .asDriver(onErrorDriveWith: .empty())
        
        targetTitleColor = titleColorDidSelected
            .asDriver(onErrorDriveWith: .empty())
        
        targetBackgroundColor = backgroundColorDidSelected
            .asDriver(onErrorDriveWith: .empty())
        
        targetFont = fontDidSelected
            .asDriver(onErrorDriveWith: .empty())
        
        targetAlignment = alignmentCellDidSelected
            .asDriver(onErrorDriveWith: .empty())
        
        targetNumberOfLines = numberOfLinesCellDidChangedLineStepper
            .asDriver(onErrorDriveWith: .empty())
        
        numberOfLinesCellStepperValueLabelText = numberOfLinesCellDidChangedLineStepper
            .asDriver(onErrorDriveWith: .empty())
        
        codeCellCodeLabelText = labelSettingCodeText
            .asDriver(onErrorDriveWith: .empty())
        
        didSeledtedFont()
        labelSettingToCode()
    }
    
    func didSeledtedFont() {
        Observable
            .combineLatest(
                fontCellDidSelected,
                fontSizeCellDidChangedFontSizeSlider
            ) { (fontType, ofSize) -> UIFont in
                fontType.font(ofSize: CGFloat(ofSize))
            }
            .bind(to: fontDidSelected)
            .disposed(by: disposeBag)
    }
    
    func colorCellDidSelected(_ objectColor: ObjectColor) {
        print(#function)
        switch objectColor.colorType {
        case .titleColor:
            titleColorDidSelected.accept(objectColor.color)
        case .backgroundColor:
            backgroundColorDidSelected.accept(objectColor.color)
        default:
            return
        }
    }

    func labelSettingToCode() {
        Observable
            .combineLatest(
                textCellDidChangedTextField,
                titleColorDidSelected,
                backgroundColorDidSelected,
                fontCellDidSelected,
                fontSizeCellDidChangedFontSizeSlider,
                alignmentCellDidSelected,
                numberOfLinesCellDidChangedLineStepper
            ).map(labelModel.codeLabelText)
            .bind(to: labelSettingCodeText)
            .disposed(by: disposeBag)
    }
    
    func labelSettingListItemSelected(_ itemType: LabelSettingListItemType) {
        switch itemType {
        case let .alignment(alignmentType: alignmentType):
            alignmentCellDidSelected.accept(alignmentType)
        case let .font(fontType: fontType):
            fontCellDidSelected.accept(fontType)
        default:
            return
        }
    }
    
    func labelSettingListDataSource() -> RxTableViewSectionedReloadDataSource<LabelSettingListSectionModel> {
        let dataSource = RxTableViewSectionedReloadDataSource<LabelSettingListSectionModel> { dataSource, tableView, indexPath, sectionModelItem in
            LabelModel.makeCell(
                dataSource[indexPath.section].sectionHeader,
                self,
                tableView,
                indexPath,
                sectionModelItem
            )
        } // RxTableViewSectionedReloadDataSource
        
        return dataSource
    } // func labelSettingListDataSource

    deinit {
        print("LabeViewModel Deinit")
    }
    
}
