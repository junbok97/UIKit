//
//  ButtonViewControllerConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import UIKit

protocol ButtonViewControllerConstantsProtocol: DefaultViewControllerConstantsProtocol {
    
    static var targetButtonHorizonOffset: CGFloat { get }
    static var targetButtonVerticalOffset: CGFloat { get }
    static var targetButtonOffset: CGFloat { get }
    static var targetTitleText: String { get }
    static var targetSubTitleText: String { get }
    static var targetTitleFont: UIFont { get }
    static var targetTitleFontSize: Int { get }
    
    static var defaultButtonCode: String { get }
}

extension ButtonViewControllerConstantsProtocol {
    static var title: String { "Button" }
    static var documentURLString: String { "https://developer.apple.com/documentation/uikit/uibutton" }
    
    static var targetButtonHorizonOffset: CGFloat { 20 }
    static var targetButtonVerticalOffset: CGFloat { 20 }
    static var targetButtonOffset: CGFloat { 20.0 }
    static var targetTitleText: String { "Title" }
    static var targetSubTitleText: String { "SubTitle" }
    static var targetTitleFont: UIFont { .systemFont(ofSize: CGFloat(ButtonFontSizeCellConstants.sliderValue)) }
    static var targetTitleFontSize: Int { Int(ButtonFontSizeCellConstants.sliderValue) }
    
    static var defaultButtonCode: String {
    """
    let button = UIButton()
    var configuration = UIButton.Configuration.filled()
    configuration.cornerStyle = .dynamic
    configuration.baseForegroundColor = nil
    configuration.baseBackgroundColor = nil
    configuration.image = nil
    configuration.imagePlacement = .leading
    configuration.titleAlignment = .center
    
    configuration.title = "Title"
    let titleTextAttribute = UIConfigurationTextAttributesTransformer { transformer in
        var transformer = transformer
        transformer.foregroundColor = nil
        transformer.font = .systemFont(ofSize: 50, weight: .regular)
        return transformer
    }
    configuration.titleTextAttributesTransformer = titleTextAttribute
    
    configuration.subtitle = "SubTitle"
    let subTitleTextAttribute = UIConfigurationTextAttributesTransformer { transformer in
        var transformer = transformer
        transformer.foregroundColor = nil
        transformer.font = .systemFont(ofSize: 50, weight: .regular)
        return transformer
    }
    configuration.subtitleTextAttributesTransformer = subTitleTextAttribute
    
    button.configuration = configuration
    """
        
    }
}

struct ButtonViewControllerConstants: ButtonViewControllerConstantsProtocol {}
