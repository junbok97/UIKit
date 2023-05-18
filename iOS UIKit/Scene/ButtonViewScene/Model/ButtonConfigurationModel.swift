//
//  ButtonConfigurationModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/17.
//

import UIKit

final class ButtonConfigurationModel {
    
    var code: String = """
    let button = UIButton()
    """
    
    lazy var button: UIButton = {
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
        return button
    }()
    
    func makeTextAttribute(
        _ fontType: ObjectFontType,
        _ ofSize: Int,
        _ color: UIColor?
    ) -> UIConfigurationTextAttributesTransformer {
        UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = color
            outgoing.font = fontType.font(ofSize: CGFloat(ofSize))
            return outgoing
        }
    }
    
    func makeButtonConfiguration(
        _ buttonStyle: ButtonStyleType,
        _ titleAlignment: ButtonTitleAlignmentType,
        _ titleText: String,
        _ titleTextAttribute: UIConfigurationTextAttributesTransformer,
        _ subTitleText: String,
        _ subTitleTextAttribute: UIConfigurationTextAttributesTransformer
    ) -> UIButton.Configuration {
        var configuration = buttonStyle.style
        configuration.titleAlignment = titleAlignment.alignment
        configuration.title = titleText
        configuration.titleTextAttributesTransformer = titleTextAttribute
        configuration.subtitle = subTitleText
        configuration.subtitleTextAttributesTransformer = subTitleTextAttribute
        return configuration
    }
    
    func settingButtonConfiguration(
        _ configuration: UIButton.Configuration,
        _ cornerStyle: ButtonCornerStyleType,
        _ foregroundColor: UIColor?,
        _ backgroundColor: UIColor?,
        _ placementType: ButtonImagePlacementType,
        _ sfSymbolSystemName: String
    ) -> UIButton.Configuration {
        var configuration = configuration
        configuration.cornerStyle = cornerStyle.cornerStyle
        configuration.baseForegroundColor = foregroundColor
        configuration.baseBackgroundColor = backgroundColor
        configuration.image = UIImage(systemName: sfSymbolSystemName)
        configuration.imagePlacement = placementType.imagePlacement
        return configuration
    }
    
    func makeConfigurationCode(
        _ style: String,
        _ corner: String,
        _ 
    ) -> String {
        
    }
    
    deinit {
        print("ButtonConfigurationModel Deinit")
    }
}
