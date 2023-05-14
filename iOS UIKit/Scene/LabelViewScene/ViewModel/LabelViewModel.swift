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
    let codeCellCodeLabelText: Driver<String>
    let textCellDidChangedTextField = PublishRelay<String>()
    let colorCellDidSelected = PublishRelay<LabelColor>()
    let fontCellDidSelected = PublishRelay<LabelFontType>()
    let fontSizeCellDidChangedFontSizeSlider = PublishRelay<Int>()
    let fontSizeCellSliderText: Driver<Int>
    let alignmentCellDidSelected = PublishRelay<LabelAlignmentType>()
    let numberOfLinesCellDidChangedLineStepper = PublishRelay<Int>()
    let numberOfLinesCellStepperValueLabelText: Driver<Int>
    let didItemSelectedLabelSettingList = PublishRelay<LabelSettingListSectionItemType>()
    
    // ViewModel -> View
    let targetText: Driver<String>
    let targetFont: Driver<UIFont>
    let targetColor: Driver<LabelColor>
    let targetAlignment: Driver<LabelAlignmentType>
    let targetNumberOfLines: Driver<Int>
    let labelSettingListCellDatas: Driver<[LabelSettingListSectionModel]>
    
    init() {
        let labelModel = LabelModel()
        labelSettingListCellDatas = labelModel.labelSettingListCellDatas
            .asDriver(onErrorDriveWith: .empty())
              
        didItemSelectedLabelSettingList
            .compactMap { labelSettingListSectionItemType -> LabelFontType? in
                guard case let .fontSectionItem(fontType) = labelSettingListSectionItemType else { return nil }
                return fontType
            }
            .bind(to: fontCellDidSelected)
            .disposed(by: disposeBag)
        
        didItemSelectedLabelSettingList
            .compactMap { labelSettingListSectionItemType -> LabelAlignmentType? in
                guard case let .alignmentSectionItem(alignmentType) = labelSettingListSectionItemType else { return nil }
                return alignmentType
            }
            .bind(to: alignmentCellDidSelected)
            .disposed(by: disposeBag)
              
        targetText = textCellDidChangedTextField
            .asDriver(onErrorDriveWith: .empty())
        
        targetColor = colorCellDidSelected
            .asDriver(onErrorDriveWith: .empty())
        
        targetFont = Observable
            .combineLatest(fontCellDidSelected, fontSizeCellDidChangedFontSizeSlider) { (fontType, ofSize) -> UIFont in
                fontType.font(ofSize: CGFloat(ofSize))
            }
            .asDriver(onErrorDriveWith: .empty())
        
        fontSizeCellSliderText = fontSizeCellDidChangedFontSizeSlider
            .asDriver(onErrorDriveWith: .empty())
        
        targetAlignment = alignmentCellDidSelected
            .asDriver(onErrorDriveWith: .empty())
        
        targetNumberOfLines = numberOfLinesCellDidChangedLineStepper
            .asDriver(onErrorDriveWith: .empty())
        
        numberOfLinesCellStepperValueLabelText = numberOfLinesCellDidChangedLineStepper
            .asDriver(onErrorDriveWith: .empty())
        
        let textCode = textCellDidChangedTextField
            .startWith(LabelViewControllerConstants.textCode)
        
        let textColorCode = colorCellDidSelected
            .filter { $0.colorType == .textColor }
            .map { "\($0.color)" }
            .startWith(LabelViewControllerConstants.textColorCode)
        
        let backgroundColorCode = colorCellDidSelected
            .filter { $0.colorType == .backgroundColor }
            .map { "\($0.color)" }
            .startWith(LabelViewControllerConstants.backgroundColorCode)
        
        let fontCode = Observable
            .combineLatest(fontCellDidSelected, fontSizeCellDidChangedFontSizeSlider) { font, ofSize in
                font.code(ofSize: CGFloat(ofSize))
            }
            .startWith(LabelViewControllerConstants.fontCode)
        
        let alignmentCode = alignmentCellDidSelected
            .map { $0.code }
            .startWith(LabelViewControllerConstants.alignmentCode)
        
        let numberOfLinesCode = numberOfLinesCellDidChangedLineStepper
            .map { "\($0)" }
            .startWith(LabelViewControllerConstants.numberOfLinesCode)
        
        codeCellCodeLabelText = Observable
            .combineLatest(textCode, textColorCode, backgroundColorCode, fontCode, alignmentCode, numberOfLinesCode, resultSelector: labelModel.codeLabelText)
            .asDriver(onErrorDriveWith: .empty())
    }
    
    func labelSettingListDataSource() -> RxTableViewSectionedReloadDataSource<LabelSettingListSectionModel> {
        let dataSource = RxTableViewSectionedReloadDataSource<LabelSettingListSectionModel> { dataSource, tableView, indexPath, sectionModelItem in
            
            switch dataSource[indexPath.section].sectionHeader {
            case .code:
                let cell = LabelCodeCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setup(sectionModelItem)
                cell.bind(self)
                return cell
            case .text:
                let cell = LabelTextCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setup(sectionModelItem)
                cell.bind(self)
                return cell
            case .color:
                let cell = LabelColorCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setup(sectionModelItem)
                cell.bind(self)
                return cell
            case .font:
                let cell = LabelFontCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setup(sectionModelItem)
                cell.bind(self)
                return cell
            case .fontSize:
                let cell = LabelFontSizeCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setup(sectionModelItem)
                cell.bind(self)
                return cell
            case .alignment:
                let cell = LabelAlignmentCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setup(sectionModelItem)
                cell.bind(self)
                return cell
            case .numberOfLines:
                let cell = LabelNumberOfLinesCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
                cell.setup(sectionModelItem)
                cell.bind(self)
                return cell
            } // Switch
        } // RxTableViewSectionedReloadDataSource
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            dataSource.sectionModels[index].sectionHeader.rawValue
        }
        
        return dataSource
        
    } // func labelSettingListDataSource
    
}
