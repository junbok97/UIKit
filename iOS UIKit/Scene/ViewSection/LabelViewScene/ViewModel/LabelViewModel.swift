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

protocol LabelViewModelProtocol: ViewModelProtocol {
    // View -> ViewModel
    var textCellDidChangedTextField: BehaviorRelay<String> { get }
    
    var titleColorDidSelected: BehaviorRelay<UIColor> { get }
    var backgroundColorDidSelected: BehaviorRelay<UIColor> { get }
    
    var fontCellDidSelected: BehaviorRelay<ObjectFontType> { get }
    var fontSizeCellDidChangedFontSizeSlider: BehaviorRelay<Int> { get }
    var fontDidSelected: BehaviorRelay<UIFont> { get }

    var alignmentCellDidSelected: BehaviorRelay<ObjectAlignmentType> { get }
    var numberOfLinesCellDidChangedLineStepper: BehaviorRelay<Int> { get }
    
    var didItemSelectedLabelSettingList: PublishRelay<LabelSettingListSectionItemType> { get }
    
    // ViewModel -> View
    var codeCellCodeLabelText: Driver<String> { get }
    var numberOfLinesCellStepperValueLabelText: Driver<Int> { get }
    var targetText: Driver<String> { get }
    var targetFont: Driver<UIFont> { get }
    var targetTitleColor: Driver<UIColor> { get }
    var targetBackgroundColor: Driver<UIColor> { get }
    var targetAlignment: Driver<ObjectAlignmentType> { get }
    var targetNumberOfLines: Driver<Int> { get }
    var labelSettingListCellDatas: Driver<[LabelSettingListSectionModel]> { get }
    
    var labelSettingCodeText: BehaviorRelay<String> { get }
    
    func didSeledtedFont()
    func colorCellDidSelected(_ labelColor: LabelColor)
    func labelSettingToCode()
    func labelSettingListDataSource() -> RxTableViewSectionedReloadDataSource<LabelSettingListSectionModel>
    func labelSettingListItemSelected(_ itemType: LabelSettingListSectionItemType)
}

final class LabelViewModel: LabelViewModelProtocol {
    
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
    
    let didItemSelectedLabelSettingList = PublishRelay<LabelSettingListSectionItemType>()
    
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
    
    init() {
        labelSettingListCellDatas = Observable.just(LabelSettingListData.settingListDatas)
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

    deinit {
        print("LabeViewModel Deinit")
    }
    
}

extension LabelViewModel {
    func labelSettingListDataSource() -> RxTableViewSectionedReloadDataSource<LabelSettingListSectionModel> {
         RxTableViewSectionedReloadDataSource<LabelSettingListSectionModel> { dataSource, tableView, indexPath, sectionModelItem in
            LabelModel.makeCell(
                dataSource[indexPath.section].sectionHeader,
                self,
                tableView,
                indexPath,
                sectionModelItem
            )
        }
    }
    
    func labelSettingListItemSelected(_ itemType: LabelSettingListSectionItemType) {
        switch itemType {
        case let .alignment(alignmentType: alignmentType):
            alignmentCellDidSelected.accept(alignmentType)
        case let .font(fontType: fontType):
            fontCellDidSelected.accept(fontType)
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
            ).map(LabelModel.codeLabelText)
            .bind(to: labelSettingCodeText)
            .disposed(by: disposeBag)
    }

    func colorCellDidSelected(_ labelColor: LabelColor) {
        switch labelColor.colorType {
        case .titleColor:
            titleColorDidSelected.accept(labelColor.color)
        case .backgroundColor:
            backgroundColorDidSelected.accept(labelColor.color)
        }
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

}
