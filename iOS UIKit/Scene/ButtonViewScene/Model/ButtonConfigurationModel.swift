//
//  ButtonConfigurationModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/16.
//

import Foundation
import RxSwift
import RxCocoa

final class ButtonConfigurationModel {
    
    private let disposeBag = DisposeBag()
    
    let textDidChangedTextField = PublishRelay<ButtonText>()
    let fontSizeDidChangedFontSizeSlider = PublishRelay<ButtonFontSize>()
    let titleAlignmentDidSelected = BehaviorRelay<ButtonTitleAlignmentType>(value: .automatic)
    
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
    
    // color
    let baseForegroundColorSelected = BehaviorRelay<UIColor>(value: .white)
    let basebackgroundColorSelected = BehaviorRelay<UIColor>(value: .tintColor)
    
    let buttonStyleDidSelected = BehaviorRelay<ButtonStyleType>(value: .filled)
    let buttonCornerStyleDidSelected = BehaviorRelay<ButtonCornerStyleType>(value: .dynamic)
    let imagePlacementDidSelected = BehaviorRelay<ButtonImagePlacementType>(value: .leading)
    
    let buttonConfigurationDidChanged = ReplayRelay<UIButton.Configuration>.create(bufferSize: 1)
    
    init() {
        print("ButtonConfigurationModel init")
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
        
        Observable.combineLatest(
            Observable
                .combineLatest(
                    buttonStyleDidSelected,
                    titleAlignmentDidSelected,
                    titleTextDidChangedTextField,
                    titleTextAttribute,
                    subTitleTextDidChangedTextField,
                    subTitleTextAttribute
                ) { (style, alignment, title, titleTextAttribute, subTitle, subTitleTextAttribute) -> UIButton.Configuration in
                    var config = style.style
                    config.titleAlignment = alignment.alignment
                    config.title = title
                    config.titleTextAttributesTransformer = titleTextAttribute
                    config.subtitle = subTitle
                    config.subtitleTextAttributesTransformer = subTitleTextAttribute
                    return config
                }
                .asObservable()
            ,
            buttonCornerStyleDidSelected,
            baseForegroundColorSelected,
            basebackgroundColorSelected,
            imagePlacementDidSelected
        ) { (config, cornerStyle, foregroundColor, backgroundColor, placement) -> UIButton.Configuration in
            var config = config
            config.cornerStyle = cornerStyle.cornerStyle
            config.baseForegroundColor = foregroundColor
            config.baseBackgroundColor = backgroundColor
            config.imagePlacement = placement.imagePlacement
            return config
        }
        .bind(to: buttonConfigurationDidChanged)
        .disposed(by: disposeBag)
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
            return
        }
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
    
    deinit {
        print("ButtonConfigurationModel Deinit")
    }
    
}
