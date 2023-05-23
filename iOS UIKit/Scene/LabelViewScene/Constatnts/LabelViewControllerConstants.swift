//
//  LabelViewConstants.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit

protocol LabelViewControllerConstantsProtocol: DefaultViewControllerConstantsProtocol {
    static var targetLabelFontSize: Int { get }
    static var targetLabelFont: UIFont { get }
    static var targetLabelOffset: CGFloat { get }
    static var targetLabelCornerRadius: CGFloat { get }
    static var targetLabelNumberOfLines: Int { get }

    static var defaultLabelCode: String { get }
}

extension LabelViewControllerConstantsProtocol {
    static var title: String { "Label" }
    static var documentURLString: String { "https://developer.apple.com/documentation/uikit/uilabel" }
    
    static var targetLabelFontSize: Int { Int(LabelFontSizeCellConstants.sliderValue) }
    static var targetLabelFont: UIFont { .systemFont(ofSize: CGFloat(LabelFontSizeCellConstants.sliderValue)) }
    static var targetLabelOffset: CGFloat { 20 }
    static var targetLabelCornerRadius: CGFloat { 8.0 }
    static var targetLabelNumberOfLines: Int { 0 }

    static var defaultLabelCode: String {
    """
    let label = UILabel()
    
    label.text = \"Label\"
    label.textColor = .label
    label.backgroundColor = .systemBackground
    label.font = .systemFont(ofSize: 50)
    label.textAlignment = .center
    label.numberOfLines = 0
    """
    }
}

struct LabelViewControllerConstants: LabelViewControllerConstantsProtocol {}
