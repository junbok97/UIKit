//
//  ButtonConfigurationModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/16.
//

import Foundation
import RxSwift
import RxCocoa

protocol ButtonConfigurationViewModelProtocol: ViewModelProtocol {
    var buttonStyleDidSelected: BehaviorRelay<ButtonStyleType> { get }
    var buttonCornerStyleDidSelected: BehaviorRelay<ButtonCornerStyleType> { get }
    
    var titleAlignmentDidSelected: BehaviorRelay<ButtonTitleAlignmentType> { get }
    
    // Title
    var titleTextDidChangedTextField: BehaviorRelay<String> { get }
    var titleFontDidSelected: BehaviorRelay<ObjectFontType> { get }
    var titleFontSizeDidChanged: BehaviorRelay<Int> { get }
    var titleColorDidSelected: BehaviorRelay<UIColor?> { get }
    
    // SubTitle
    var subTitleTextDidChangedTextField: BehaviorRelay<String> { get }
    var subTitleFontDidSelected: BehaviorRelay<ObjectFontType> { get }
    var subTitleFontSizeDidChanged: BehaviorRelay<Int> { get }
    var subTitleColorDidSelected: BehaviorRelay<UIColor?> { get }
    
    // color
    var tintColorSelected: BehaviorRelay<UIColor> { get }
    var baseForegroundColorSelected: BehaviorRelay<UIColor?> { get }
    var basebackgroundColorSelected: BehaviorRelay<UIColor?> { get }
    
    var sfSymbolDidSeleted: BehaviorRelay<String> { get }
    var imagePlacementDidSelected: BehaviorRelay<ButtonImagePlacementType> { get }
    
    var buttonSettingCodeText: BehaviorRelay<String> { get }
    var buttonConfigurationDidChanged: BehaviorRelay<UIButton.Configuration> { get }
    
    func colorCellDidSelected(_ buttonColor: ButtonColor)
    func buttonSettingListItemSelected(_ itemType: ButtonSettingListItemType)
    func sfSymbolDidSeleted(_ sfSymbolName: String)
    func textDidChanged(_ buttonText: ButtonText)
    func fontSizeDidChanged(_ buttonFontSize: ButtonFontSize)
    func buttonSettingToCode()
    func tintColorDidSelected(_ color: UIColor)
    func titleColorDidSelected(_ color: UIColor)
    func subTitleColorDidSelected(_ color: UIColor)
    func baseForegroundColorSelected(_ color: UIColor)
    func basebackgroundColorSelected(_ color: UIColor)
    func buttonStyleDidSelected(_ buttonStyleType: ButtonStyleType)
    func buttonCornerStyleDidSelected(_ cornerStyleType: ButtonCornerStyleType)
    func titleAlignmentDidSelected(_ titleAligmentType: ButtonTitleAlignmentType)
    func fontDidSeleted(_ titleType: ButtonTitleType, _ fontType: ObjectFontType)
    func imagePlacementDidSelected(_ imagePlacementType: ButtonImagePlacementType)
}

final class ButtonConfigurationViewModel: ButtonConfigurationViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    
    let buttonStyleDidSelected = BehaviorRelay<ButtonStyleType>(value: .filled)
    let buttonCornerStyleDidSelected = BehaviorRelay<ButtonCornerStyleType>(value: .dynamic)
    
    let titleAlignmentDidSelected = BehaviorRelay<ButtonTitleAlignmentType>(value: .automatic)
    
    // Title
    let titleTextDidChangedTextField = BehaviorRelay<String>(value: ButtonViewControllerConstants.targetTitleText)
    let titleFontDidSelected = BehaviorRelay<ObjectFontType>(value: .regular)
    let titleFontSizeDidChanged = BehaviorRelay<Int>(value: ButtonViewControllerConstants.targetTitleFontSize)
    let titleColorDidSelected = BehaviorRelay<UIColor?>(value: nil)
    
    // SubTitle
    let subTitleTextDidChangedTextField = BehaviorRelay<String>(value: ButtonViewControllerConstants.targetSubTitleText)
    let subTitleFontDidSelected = BehaviorRelay<ObjectFontType>(value: .regular)
    let subTitleFontSizeDidChanged = BehaviorRelay<Int>(value: ButtonViewControllerConstants.targetTitleFontSize)
    let subTitleColorDidSelected = BehaviorRelay<UIColor?>(value: nil)
    
    // color
    let tintColorSelected = BehaviorRelay<UIColor>(value: .tintColor)
    let baseForegroundColorSelected = BehaviorRelay<UIColor?>(value: nil)
    let basebackgroundColorSelected = BehaviorRelay<UIColor?>(value: nil)
    
    let sfSymbolDidSeleted = BehaviorRelay<String>(value: "")
    let imagePlacementDidSelected = BehaviorRelay<ButtonImagePlacementType>(value: .leading)
    
    let buttonSettingCodeText = BehaviorRelay<String>(value: ButtonViewControllerConstants.defaultButtonCode)
    let buttonConfigurationDidChanged = BehaviorRelay<UIButton.Configuration>(value: .filled())
    
    init() {
        let titleTextAttribute = Observable
            .combineLatest(
                titleFontDidSelected,
                titleFontSizeDidChanged,
                titleColorDidSelected
            )
            .map(ButtonConfigurationModel.makeTextAttribute)
        
        let subTitleTextAttribute = Observable
            .combineLatest(
                subTitleFontDidSelected,
                subTitleFontSizeDidChanged,
                subTitleColorDidSelected
            )
            .map(ButtonConfigurationModel.makeTextAttribute)
        
        let buttonConfiguration = Observable
            .combineLatest(
                buttonStyleDidSelected,
                titleAlignmentDidSelected,
                titleTextDidChangedTextField,
                titleTextAttribute,
                subTitleTextDidChangedTextField,
                subTitleTextAttribute
            ).map(ButtonConfigurationModel.makeButtonConfiguration)
        
        Observable.combineLatest(
            buttonConfiguration,
            buttonCornerStyleDidSelected,
            baseForegroundColorSelected,
            basebackgroundColorSelected,
            imagePlacementDidSelected,
            sfSymbolDidSeleted
        )
        .map(ButtonConfigurationModel.settingButtonConfiguration)
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
        case let .buttonStyle(type: type):
            buttonStyleDidSelected(type)
        case let .corner(type: type):
            buttonCornerStyleDidSelected(type)
        case let .buttonTitleAlignment(type: type):
            titleAlignmentDidSelected(type)
        case let .font(titleType: titleType, fontType: fontType):
            fontDidSeleted(titleType, fontType)
        case let .imagePlacement(type: type):
            imagePlacementDidSelected(type)
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
        ).map(ButtonConfigurationModel.configurationToCode)
        
        let titleTextAttributeCode = Observable.combineLatest(
            titleAlignmentCode,
            titleCode,
            titleFontCode,
            titleColorDidSelected
        ).map(ButtonConfigurationModel.titleTextAttributeToCode)
        
        let subTitleTextAttributeCode = Observable.combineLatest(
            subTitleCode,
            subTitleFontCode,
            subTitleColorDidSelected
        ).map(ButtonConfigurationModel.subTitleTextAttributeToCode)
        
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
