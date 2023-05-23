//
//  ButtonConfigurationModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/17.
//

import UIKit

final class ButtonConfigurationModel {
    
    static func makeTextAttribute(
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
    
    static func makeButtonConfiguration(
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
    
    static func settingButtonConfiguration(
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
    
    static func configurationToCode(
        _ style: String,
        _ corner: String,
        _ tintColor: UIColor?,
        _ foregroundColor: UIColor?,
        _ backgroundColor: UIColor?,
        _ image: String,
        _ imagePlacement: String
    ) -> String {
        """
        let button = UIButton()
        var configuration = \(style)
        
        button.tintColor = \(tintColor == nil ? "nil" : tintColor!.cgColor.getRGBCode)
        configuration.baseForegroundColor = \(foregroundColor == nil ? "nil" : foregroundColor!.cgColor.getRGBCode)
        configuration.baseBackgroundColor = \(backgroundColor == nil ? "nil" : backgroundColor!.cgColor.getRGBCode)
        
        configuration.cornerStyle = \(corner)
        
        configuration.image = \(image)
        configuration.imagePlacement = \(imagePlacement)
        \n
        """
    }
        
    static func titleTextAttributeToCode(
        titleAlignment: String,
        title: String,
        titleFont: String,
        titleColor: UIColor?
    ) -> String {
        """
        configuration.titleAlignment = \(titleAlignment)
            
        configuration.title = "\(title)"
        let titleTextAttribute = UIConfigurationTextAttributesTransformer { transformer in
            var transformer = transformer
            transformer.font = \(titleFont)
            transformer.foregroundColor = \(titleColor == nil ? "nil" : titleColor!.cgColor.getRGBCode)
            return transformer
        }
        configuration.titleTextAttributesTransformer = titleTextAttribute
        \n
        """
    }
    
    static func subTitleTextAttributeToCode(
        subTitle: String,
        subTitleFont: String,
        subTitleColor: UIColor?
    ) -> String {
        """
        configuration.subTitle = "\(subTitle)"
        let subTitleTextAttribute = UIConfigurationTextAttributesTransformer { transformer in
            var transformer = transformer
            transformer.font = \(subTitleFont)
            transformer.foregroundColor = \(subTitleColor == nil ? "nil" : subTitleColor!.cgColor.getRGBCode)
            return transformer
        }
        configuration.subTitleTextAttributesTransformer = subTitleTextAttribute
        
        button.configuration = configuration
        """
    }
    
    deinit {
        print("ButtonConfigurationModel Deinit")
    }
}
