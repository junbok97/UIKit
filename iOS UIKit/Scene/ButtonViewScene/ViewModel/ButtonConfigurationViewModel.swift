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
    
    let titleAlignmentDidSelected = BehaviorRelay<ButtonTitleAlignmentType>(value: .automatic)
    
    // Title
    let titleTextDidChangedTextField = BehaviorRelay<String>(value: ButtonViewControllerConstants.targetTitleText)
    let titleFontDidSelected = BehaviorRelay<ObjectFontType>(value: .regular)
    let titleFontSizeDidChanged = BehaviorRelay<Int>(value: ButtonViewControllerConstants.targetTitleFontSize)
    let titleColorDidSelected = BehaviorRelay<UIColor>(value: .white)
    
    // SubTitle
    let subTitleTextDidChangedTextField = BehaviorRelay<String>(value: ButtonViewControllerConstants.targetSubTitleText)
    let subTitleFontDidSelected = BehaviorRelay<ObjectFontType>(value: .regular)
    let subTitleFontSizeDidChanged = BehaviorRelay<Int>(value: ButtonViewControllerConstants.targetTitleFontSize)
    let subTitleColorDidSelected = BehaviorRelay<UIColor>(value: .white)
    
    // color
    let baseForegroundColorSelected = BehaviorRelay<UIColor>(value: .white)
    let basebackgroundColorSelected = BehaviorRelay<UIColor>(value: .tintColor)
    
    let buttonStyleDidSelected = BehaviorRelay<ButtonStyleType>(value: .filled)
    let buttonCornerStyleDidSelected = BehaviorRelay<ButtonCornerStyleType>(value: .dynamic)
    
    let imageDidSelected = BehaviorRelay<UIImage?>(value: nil)
    let imagePlacementDidSelected = BehaviorRelay<ButtonImagePlacementType>(value: .leading)
    
    let buttonConfigurationDidChanged = ReplayRelay<UIButton.Configuration>.create(bufferSize: 1)
    
    init() {
        let buttonConfigurationModel = ButtonConfigurationModel()
        
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
            imageDidSelected
        )
        .map(buttonConfigurationModel.settingButtonConfiguration)
        .bind(to: buttonConfigurationDidChanged)
        .disposed(by: disposeBag)
        
    }
    
    func configToCode(_ config: UIButton.Configuration) {
        
    }
    
    func sfSymbolsSystemName(_ sfSymbolsName: String) {
        imageDidSelected.accept(UIImage(systemName: sfSymbolsName))
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
    
    func buttonSettingListItemSelected(_ itemType: ButtonSettingListItemType) {
        switch itemType {
        case let .buttonStyle(buttonStyle: buttonStyle):
            buttonStyleDidSelected.accept(buttonStyle)
        case let .corner(cornerStyleType: cornerStyle):
            buttonCornerStyleDidSelected.accept(cornerStyle)
        case let .buttonTitleAlignment(aligmentType: alignmentType):
            titleAlignmentDidSelected.accept(alignmentType)
        case let .font(titleType: titleType, fontType: fontType):
            switch titleType {
            case .title:
                titleFontDidSelected.accept(fontType)
            case .subTitle:
                subTitleFontDidSelected.accept(fontType)
            }
        case let .imagePlacement(placement: placement):
            imagePlacementDidSelected.accept(placement)
        default:
            return
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
    
    deinit {
        print("ButtonConfigurationViewModel Deinit")
    }
    
}
