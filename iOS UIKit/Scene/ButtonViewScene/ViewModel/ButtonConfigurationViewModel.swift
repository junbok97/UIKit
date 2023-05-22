//
//  ButtonConfigurationModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/16.
//

import Foundation
import RxSwift
import RxCocoa

final class ButtonConfigurationViewModel {
    
    private let disposeBag = DisposeBag()
    
    private let buttonStyleDidSelected = BehaviorRelay<ButtonStyleType>(value: .filled)
    private let buttonCornerStyleDidSelected = BehaviorRelay<ButtonCornerStyleType>(value: .dynamic)
    
    private let titleAlignmentDidSelected = BehaviorRelay<ButtonTitleAlignmentType>(value: .automatic)
    
    // Title
    private let titleTextDidChangedTextField = BehaviorRelay<String>(value: ButtonViewControllerConstants.targetTitleText)
    private let titleFontDidSelected = BehaviorRelay<ObjectFontType>(value: .regular)
    private let titleFontSizeDidChanged = BehaviorRelay<Int>(value: ButtonViewControllerConstants.targetTitleFontSize)
    private let titleColorDidSelected = BehaviorRelay<UIColor?>(value: nil)
    
    // SubTitle
    private let subTitleTextDidChangedTextField = BehaviorRelay<String>(value: ButtonViewControllerConstants.targetSubTitleText)
    private let subTitleFontDidSelected = BehaviorRelay<ObjectFontType>(value: .regular)
    private let subTitleFontSizeDidChanged = BehaviorRelay<Int>(value: ButtonViewControllerConstants.targetTitleFontSize)
    private let subTitleColorDidSelected = BehaviorRelay<UIColor?>(value: nil)
    
    // color
    let tintColorSelected = BehaviorRelay<UIColor>(value: .tintColor)
    private let baseForegroundColorSelected = BehaviorRelay<UIColor?>(value: nil)
    private let basebackgroundColorSelected = BehaviorRelay<UIColor?>(value: nil)
    
    private let sfSymbolDidSeleted = BehaviorRelay<String>(value: "")
    private let imagePlacementDidSelected = BehaviorRelay<ButtonImagePlacementType>(value: .leading)
    
    let buttonSettingCodeText = BehaviorRelay<String>(value: ButtonViewControllerConstants.defaultButtonCode)
    let buttonConfigurationDidChanged = BehaviorRelay<UIButton.Configuration>(value: .filled())
    
    private let buttonConfigurationModel = ButtonConfigurationModel()
    
    init() {
        let titleTextAttribute = Observable
            .combineLatest(
                titleFontDidSelected,
                titleFontSizeDidChanged,
                titleColorDidSelected
            )
            .map(buttonConfigurationModel.makeTextAttribute)
        
        let subTitleTextAttribute = Observable
            .combineLatest(
                subTitleFontDidSelected,
                subTitleFontSizeDidChanged,
                subTitleColorDidSelected
            )
            .map(buttonConfigurationModel.makeTextAttribute)
        
        let buttonConfiguration = Observable
            .combineLatest(
                buttonStyleDidSelected,
                titleAlignmentDidSelected,
                titleTextDidChangedTextField,
                titleTextAttribute,
                subTitleTextDidChangedTextField,
                subTitleTextAttribute
            ).map(buttonConfigurationModel.makeButtonConfiguration)
        
        Observable.combineLatest(
            buttonConfiguration,
            buttonCornerStyleDidSelected,
            baseForegroundColorSelected,
            basebackgroundColorSelected,
            imagePlacementDidSelected,
            sfSymbolDidSeleted
        )
        .map(buttonConfigurationModel.settingButtonConfiguration)
        .bind(to: buttonConfigurationDidChanged)
        .disposed(by: disposeBag)
        
        buttonSettingToCode()
    }
    
    deinit {
        print("ButtonConfigurationViewModel Deinit")
    }
    
}

extension ButtonConfigurationViewModel {
    func colorCellDidSelected(_ buttonColor: ButtonColor) {
        switch buttonColor.colorType {
        case .tintColor:
            tintColorDidSelected(buttonColor.color)
        case .titleColor:
            titleColorDidSelected(buttonColor.color)
        case .subTitleColor:
            subTitleColorDidSelected(buttonColor.color)
        case .foregroundColor:
            baseForegroundColorSelected(buttonColor.color)
        case .backgroundColor:
            basebackgroundColorSelected(buttonColor.color)
        }
    }
    
    func buttonSettingListItemSelected(_ itemType: ButtonSettingListItemType) {
        switch itemType {
        case let .buttonStyle(buttonStyle: buttonStyle):
            buttonStyleDidSelected(buttonStyle)
        case let .corner(cornerStyleType: cornerStyle):
            buttonCornerStyleDidSelected(cornerStyle)
        case let .buttonTitleAlignment(aligmentType: alignmentType):
            titleAlignmentDidSelected(alignmentType)
        case let .font(titleType: titleType, fontType: fontType):
            fontDidSeleted(titleType, fontType)
        case let .imagePlacement(placement: placement):
            imagePlacementDidSelected(placement)
        default:
            return
        }
    }

    
    func sfSymbolDidSeleted(_ sfSymbolName: String) {
        sfSymbolDidSeleted.accept(sfSymbolName)
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

}

private extension ButtonConfigurationViewModel {
    
    func buttonSettingToCode() {
        let styleCode = buttonStyleDidSelected.map { $0.code }
        let cornerStyleCode = buttonCornerStyleDidSelected.map { $0.code }
        
        let titleAlignmentCode = titleAlignmentDidSelected.map { $0.code }
        let titleCode = titleTextDidChangedTextField
        let titleFontCode = Observable.combineLatest(
            titleFontDidSelected,
            titleFontSizeDidChanged
        ) { fontType, ofSize in
            fontType.code(ofSize: CGFloat(ofSize))
        }
        
        let subTitleCode = subTitleTextDidChangedTextField
        let subTitleFontCode = Observable.combineLatest(
            subTitleFontDidSelected,
            subTitleFontSizeDidChanged
        ) { fontType, ofSize in
            fontType.code(ofSize: CGFloat(ofSize))
        }
        
        let imageCode = sfSymbolDidSeleted.map {
            $0 == "" ? "nil" : "UIImage(systemName: \($0))"
        }
        let imagePlacementCode = imagePlacementDidSelected.map { $0.code }
        
        let configurationCode = Observable.combineLatest(
            styleCode,
            cornerStyleCode,
            tintColorSelected,
            baseForegroundColorSelected,
            basebackgroundColorSelected,
            imageCode,
            imagePlacementCode
        ).map(buttonConfigurationModel.configurationToCode)
        
        let titleTextAttributeCode = Observable.combineLatest(
            titleAlignmentCode,
            titleCode,
            titleFontCode,
            titleColorDidSelected
        ).map(buttonConfigurationModel.titleTextAttributeToCode)
        
        let subTitleTextAttributeCode = Observable.combineLatest(
            subTitleCode,
            subTitleFontCode,
            subTitleColorDidSelected
        ).map(buttonConfigurationModel.subTitleTextAttributeToCode)
        
        Observable.combineLatest(
            configurationCode,
            titleTextAttributeCode,
            subTitleTextAttributeCode
        ).map { $0 + $1 + $2 }
            .bind(to: buttonSettingCodeText)
            .disposed(by: disposeBag)
    }
    
    func tintColorDidSelected(_ color: UIColor) {
        tintColorSelected.accept(color)
    }
    
    func titleColorDidSelected(_ color: UIColor) {
        titleColorDidSelected.accept(color)
    }
    
    func subTitleColorDidSelected(_ color: UIColor) {
        subTitleColorDidSelected.accept(color)
    }
    
    func baseForegroundColorSelected(_ color: UIColor) {
        baseForegroundColorSelected.accept(color)
    }
    
    func basebackgroundColorSelected(_ color: UIColor) {
        basebackgroundColorSelected.accept(color)
    }
    
    func buttonStyleDidSelected(_ buttonStyleType: ButtonStyleType) {
        buttonStyleDidSelected.accept(buttonStyleType)
        titleColorDidSelected.accept(nil)
        subTitleColorDidSelected.accept(nil)
        baseForegroundColorSelected.accept(nil)
        basebackgroundColorSelected.accept(nil)
    }
    
    func buttonCornerStyleDidSelected(_ cornerStyleType: ButtonCornerStyleType) {
        buttonCornerStyleDidSelected.accept(cornerStyleType)
    }
    
    func titleAlignmentDidSelected(_ titleAligmentType: ButtonTitleAlignmentType) {
        titleAlignmentDidSelected.accept(titleAligmentType)
    }
    
    func fontDidSeleted(_ titleType: ButtonTitleType, _ fontType: ObjectFontType) {
        switch titleType {
        case .title:
            titleFontDidSelected.accept(fontType)
        case .subTitle:
            subTitleFontDidSelected.accept(fontType)
        }
    }
    
    func imagePlacementDidSelected(_ imagePlacementType: ButtonImagePlacementType) {
        imagePlacementDidSelected.accept(imagePlacementType)
    }
    
}
