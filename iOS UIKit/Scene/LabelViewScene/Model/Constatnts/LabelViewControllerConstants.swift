//
//  LabelViewConstants.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit

struct LabelViewControllerConstants {
    static let defaultOffset: CGFloat = 12.0
    static let defaultFontSize: CGFloat = 16.0
    static let defaultFont: UIFont = .systemFont(ofSize: 16)
    
    static let title: String = "Label"
    static let targetLabelFontSize: Float = 50.0
    static let targetLabelFont: UIFont = .systemFont(ofSize: 50)
    static let targetLabelOffset: CGFloat = 20
    static let targetLabelCornerRadius: CGFloat = 8.0
    static let targetLabelNumberOfLines: Int = 0

    static let defaultLabelCode: String =
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
