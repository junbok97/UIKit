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
    private let baseForegroundColorSelected = BehaviorRelay<UIColor?>(value: nil)
    private let basebackgroundColorSelected = BehaviorRelay<UIColor?>(value: nil)
    
    private let sfSymbolDidSeleted = BehaviorRelay<String>(value: "")
    private let imagePlacementDidSelected = BehaviorRelay<ButtonImagePlacementType>(value: .leading)
    
    let buttonConfigurationCode = BehaviorRelay<String>(value: ButtonViewControllerConstants.defaultButtonCode)
    let buttonConfigurationDidChanged = BehaviorRelay<UIButton.Configuration>(value: .filled())
    
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
            sfSymbolDidSeleted
        )
        .map(buttonConfigurationModel.settingButtonConfiguration)
        .bind(to: buttonConfigurationDidChanged)
        .disposed(by: disposeBag)
        
        configToCode()
    }
    
    func configToCode() {
        let styleCode = buttonStyleDidSelected.map { $0.code }
        let cornerStyleCode = buttonCornerStyleDidSelected.map { $0.code }
        
        let titleAlignmentCode = titleAlignmentDidSelected.map { $0.code }
        let titleCode = titleTextDidChangedTextField
        let titleFontCode = Observable.combineLatest(titleFontDidSelected, titleFontSizeDidChanged) { fontType, ofSize in
            fontType.code(ofSize: CGFloat(ofSize))
        }
        
        let subTitleCode = subTitleTextDidChangedTextField
        let subTitleFontCode = Observable.combineLatest(subTitleFontDidSelected, subTitleFontSizeDidChanged) { fontType, ofSize in
            fontType.code(ofSize: CGFloat(ofSize))
        }
        
        let imageCode = sfSymbolDidSeleted.map {
            $0 == "" ? "nil" : "UIImage(systemName: \($0))"
        }
        let imagePlacementCode = imagePlacementDidSelected.map { $0.code }
        
        let configurationCode = Observable
            .combineLatest(styleCode, cornerStyleCode, baseForegroundColorSelected, basebackgroundColorSelected, imageCode, imagePlacementCode) { style, corner, foregroundColor, backgroundColor, image, imagePlacement in
                """
                let button = UIButton()
                var configuration = \(style)
                configuration.cornerStyle = \(corner)
                configuration.baseForegroundColor = \(foregroundColor == nil ? "nil" : "titleColor!")
                configuration.baseBackgroundColor = \(backgroundColor == nil ? "nil" : "titleColor!")
                configuration.image = \(image)
                configuration.imagePlacement = \(imagePlacement)
                \n
                """
        }
        
        let titleTextAttributeCode = Observable.combineLatest(titleAlignmentCode, titleCode, titleFontCode, titleColorDidSelected) { titleAlignment, title, titleFont, titleColor in
            """
            configuration.titleAlignment = \(titleAlignment)
            
            configuration.title = "\(title)"
            let titleTextAttribute = UIConfigurationTextAttributesTransformer { transformer in
                var transformer = transformer
                transformer.font = \(titleFont)
                transformer.foregroundColor = \(titleColor == nil ? "nil" : "\(titleColor!)")
                return transformer
            }
            configuration.titleTextAttributesTransformer = titleTextAttribute
            \n
            """
        }
        
        let subTitleTextAttributeCode = Observable.combineLatest(subTitleCode, subTitleFontCode, subTitleColorDidSelected) { subTitle, subTitleFont, subTitleColor in
            """
            configuration.subTitle = "\(subTitle)"
            let subTitleTextAttribute = UIConfigurationTextAttributesTransformer { transformer in
                var transformer = transformer
                transformer.font = \(subTitleFont)
                transformer.foregroundColor = \(subTitleColor == nil ? "nil" : "\(subTitleColor!)")
                return transformer
            }
            configuration.subTitleTextAttributesTransformer = subTitleTextAttribute
            
            button.configuration = configuration
            """
        }
        
        Observable
            .combineLatest(configurationCode, titleTextAttributeCode, subTitleTextAttributeCode).map { $0 + $1 + $2 }
            .bind(to: buttonConfigurationCode)
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("ButtonConfigurationViewModel Deinit")
    }
    
}

extension ButtonConfigurationViewModel {
    func sfSymbolDidSeleted(_ sfSymbolName: String) {
        sfSymbolDidSeleted.accept(sfSymbolName)
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
