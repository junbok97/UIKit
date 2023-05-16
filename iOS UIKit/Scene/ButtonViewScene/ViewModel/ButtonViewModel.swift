//
//  ButtonViewModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class ButtonViewModel {
    
    private let disposeBag = DisposeBag()
    
    // View -> ViewModel
    let textDidChangedTextField = PublishRelay<ButtonText>()
    let fontSizeDidChangedFontSizeSlider = PublishRelay<ButtonFontSize>()
    // Title
    let titleTextDidChangedTextField = BehaviorRelay<String>(value: ButtonViewControllerConstants.targetTitleText)
    let titleFontDidSelected = BehaviorRelay<ObjectFontType>(value: .regular)
    let titleFontSizeDidChanged = BehaviorRelay<Int>(value: ButtonViewControllerConstants.targetTitleFontSize)
    let titleColorDidSelected = BehaviorRelay<UIColor>(value: .white)
    let titleTextAttribute = ReplayRelay<UIConfigurationTextAttributesTransformer>.create(bufferSize: 1)
    
    // SubTitle
    let subTitleTextDidChangedTextField = BehaviorRelay<String>(value: ButtonViewControllerConstants.targetSubTitleText)
    let subTitleFontDidSelected = BehaviorRelay<ObjectFontType>(value: .regular)
    let subTitleFontSizeDidChanged = BehaviorRelay<Int>(value: ButtonViewControllerConstants.targetTitleFontSize)
    let subTitleColorDidSelected = BehaviorRelay<UIColor>(value: .white)
    let subTitleTextAttribute = ReplayRelay<UIConfigurationTextAttributesTransformer>.create(bufferSize: 1)
    
    let baseForegroundColorSelected = BehaviorRelay<UIColor>(value: .white)
    let basebackgroundColorSelected = BehaviorRelay<UIColor>(value: .tintColor)
    
    let buttonStyleDidSelected = BehaviorRelay<ButtonStyleType>(value: .filled)
    let titleAlignmentDidSelected = BehaviorRelay<ButtonTitleAlignmentType>(value: .automatic)
    
    let buttonConfigurationDidChanged = ReplayRelay<UIButton.Configuration>.create(bufferSize: 1)
    let colorCellSelected = PublishRelay<ObjectColor>()
    
    // ViewModel -> View
    let buttonSettingListCellDatas: Driver<[ButtonSettingListSectionModel]>
    
        let targetButtonConfiguration: Driver<UIButton.Configuration>
        let targetColor: Driver<ObjectColor>
    //    let targetTitleAlignment: Driver<UIButton.Configuration.TitleAlignment>
    //    let targetTitleTextAttribute: Driver<UIConfigurationTextAttributesTransformer>
    //    let targetSubTitleTextAttribute: Driver<UIConfigurationTextAttributesTransformer>
    //
    init() {
        let buttonModel = ButtonModel()
        buttonSettingListCellDatas = buttonModel.buttonSettingListCellDatas
            .asDriver(onErrorDriveWith: .empty())
        
        targetButtonConfiguration = buttonConfigurationDidChanged
            .asDriver(onErrorDriveWith: .empty())
        
        targetColor = colorCellSelected
            .asDriver(onErrorDriveWith: .empty())
        
        textDidChangedTextField
            .subscribe(onNext: textDidChanged)
            .disposed(by: disposeBag)
        
        fontSizeDidChangedFontSizeSlider
            .subscribe(onNext: fontSizeDidChanged)
            .disposed(by: disposeBag)
        
        Observable
            .combineLatest(
                titleFontDidSelected,
                titleFontSizeDidChanged,
                titleColorDidSelected
            )
            .map(makeTextAttribute)
            .bind(to: titleTextAttribute)
            .disposed(by: disposeBag)
        
        Observable
            .combineLatest(
                subTitleFontDidSelected,
                subTitleFontSizeDidChanged,
                subTitleColorDidSelected
            )
            .map(makeTextAttribute)
            .bind(to: subTitleTextAttribute)
            .disposed(by: disposeBag)
        
        Observable
            .combineLatest(
                buttonStyleDidSelected,
                titleAlignmentDidSelected,
                titleTextDidChangedTextField,
                titleTextAttribute,
                subTitleTextDidChangedTextField,
                subTitleTextAttribute,
                baseForegroundColorSelected,
                basebackgroundColorSelected
            ) { (style, alignment, title, titleTextAttribute, subTitle, subTitleTextAttribute, forgroundColor, backgroundColor) -> UIButton.Configuration in
                var config = style.style
                config.titleAlignment = alignment.alignment
                config.baseForegroundColor = forgroundColor
                config.baseBackgroundColor = backgroundColor
                config.title = title
                config.titleTextAttributesTransformer = titleTextAttribute
                config.subtitle = subTitle
                config.subtitleTextAttributesTransformer = subTitleTextAttribute
                return config
            }.bind(to: buttonConfigurationDidChanged)
            .disposed(by: disposeBag)
    }
    
    func makeTextAttribute(
        _ fontType: ObjectFontType,
        _ ofSize: Int,
        _ color: UIColor
    ) -> UIConfigurationTextAttributesTransformer {
        UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = color
            outgoing.font = fontType.font(ofSize: CGFloat(ofSize))
            return outgoing
        }
    }
    
    func textDidChanged(_ buttonText: ButtonText) {
        switch buttonText.titleType {
        case .title:
            titleTextDidChangedTextField.accept(buttonText.text)
        case .subTitle:
            subTitleTextDidChangedTextField.accept(buttonText.text)
        }
    }
    
    func fontSizeDidChanged(_ buttonFontSize: ButtonFontSize) {
        switch buttonFontSize.titleType {
        case .title:
            titleFontSizeDidChanged.accept(buttonFontSize.fontSize)
        case .subTitle:
            subTitleFontSizeDidChanged.accept(buttonFontSize.fontSize)
        }
    }

    func colorCellDidSelected(_ objectColor: ObjectColor) {
        switch objectColor.colorType {
        case .titleColor:
            titleColorDidSelected.accept(objectColor.color)
        case .subTitleColor:
            subTitleColorDidSelected.accept(objectColor.color)
        case .foregroundColor:
            baseForegroundColorSelected.accept(objectColor.color)
        case .backgroundColor:
            basebackgroundColorSelected.accept(objectColor.color)
        default:
            colorCellSelected.accept(objectColor)
        }
    }
    
    func buttonSettingListItemSelected(_ itemType: ButtonSettingListItemType) {
        switch itemType {
        case let .buttonTitleAlignment(aligmentType: alignmentType):
            titleAlignmentDidSelected.accept(alignmentType)
        case let .font(titleType: titleType, fontType: fontType):
            switch titleType {
            case .title:
                titleFontDidSelected.accept(fontType)
            case .subTitle:
                subTitleFontDidSelected.accept(fontType)
            }
        default:
            return
        }
    }
    
    func buttonSettingListDataSource() -> RxTableViewSectionedReloadDataSource<ButtonSettingListSectionModel> {
        
        let dataSource = RxTableViewSectionedReloadDataSource<ButtonSettingListSectionModel> { dataSource, tableView, indexPath, sectionModelItem in
            ButtonModel.makeCell(
                dataSource[indexPath.section].sectionHeader,
                self,
                tableView,
                indexPath,
                sectionModelItem
            )
        } // RxTableViewSectionedReloadDataSource
        return dataSource
    }
    
    deinit {
        print("ButtonViewModel Deinit")
    }
}
