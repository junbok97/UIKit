//
//  ButtonViewControllerConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import UIKit

struct ButtonViewControllerConstants {
    static let defaultOffset: CGFloat = 12.0
    static let defaultFontSize: Int = 16
    static let defaultFont: UIFont = .systemFont(ofSize: 16)
    
    
    static let title: String = "Button"
    static let targetButtonHorizonOffset: CGFloat = 20
    static let targetButtonVerticalOffset: CGFloat = 20
    
    static let targetButtonOffset: CGFloat = 20.0
    
    static let targetTitleText: String = "Title"
    static let targetSubTitleText: String = "SubTitle"
    static let targetTitleFont: UIFont = .systemFont(ofSize: 50)
    static let targetTitleFontSize: Int = 50
    
    
    static let defaultButtonCode: String =
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
