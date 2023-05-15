//
//  DefaultFontSizeCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit

struct DefaultFontSizeCellConstants {
    static let cellId: String = "DefaultFontSizeCell"
    static let sizeLabelText: String = "Font Size"
    static let minNumLabelText: String = "1"
    static let sliderMinimumValue: Float = 1.0
    static let maxNumLabelText: String = "100"
    static let sliderMaximimValue: Float = 100.0
    static let numLabelWidth: CGFloat = 30.0
    static let sliderValueLabelText: String = "50"
    static let sliderValue: Float = 50.0
    static let sliderStackViewSpacing: CGFloat = 15.0
    
    static let numLabelContentCompressionResistancePriority: UILayoutPriority = UILayoutPriority(751)
    static let sliderContentCompressionResistancePriority: UILayoutPriority = UILayoutPriority(750)
}
