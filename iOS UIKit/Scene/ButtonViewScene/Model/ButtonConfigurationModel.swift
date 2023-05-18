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
        configuration.title = "Title"
        configuration.subtitle = "SubTitle"
        configuration.titleAlignment = .center
        
        let titleTextAttribute = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = .red
            outgoing.font = .systemFont(ofSize: 20, weight: .regular)
            return outgoing
        }
        
        let subTitleTextAttribute = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.foregroundColor = .red
            outgoing.font = .systemFont(ofSize: 20, weight: .regular)
            return outgoing
        }
        
        configuration.titleTextAttributesTransformer = titleTextAttribute
        configuration.subtitleTextAttributesTransformer = subTitleTextAttribute
        
        configuration.cornerStyle = .dynamic
        configuration.baseForegroundColor = .red
        configuration.baseBackgroundColor = .blue
        configuration.image = nil
        configuration.imagePlacement = .all
        return button
    }()
    
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
        _ foregroundColor: UIColor,
        _ backgroundColor: UIColor,
        _ placementType: ButtonImagePlacementType,
        _ image: UIImage?
    ) -> UIButton.Configuration {
        var configuration = configuration
        configuration.cornerStyle = cornerStyle.cornerStyle
        configuration.baseForegroundColor = foregroundColor
        configuration.baseBackgroundColor = backgroundColor
        configuration.image = image
        configuration.imagePlacement = placementType.imagePlacement
        return configuration
    }
    
    deinit {
        print("ButtonConfigurationModel Deinit")
    }
}
