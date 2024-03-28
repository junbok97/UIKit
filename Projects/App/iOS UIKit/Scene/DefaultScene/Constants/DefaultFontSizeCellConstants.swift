//
//  DefaultFontSizeCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit

protocol DefaultFontSizeCellConstantsProtocol: DefaultCellConstantsProtocol {
    static var sizeLabelText: String { get }
    static var minNumLabelText: String { get }
    static var sliderMinimumValue: Float { get }
    static var maxNumLabelText: String { get }
    static var sliderMaximimValue: Float { get }
    static var numLabelWidth: CGFloat { get }
    static var sliderValueLabelText: String { get }
    static var sliderValue: Float { get }
    static var sliderStackViewSpacing: CGFloat { get }
    
    static var numLabelContentCompressionResistancePriority: UILayoutPriority { get }
    static var sliderContentCompressionResistancePriority: UILayoutPriority { get }
}

extension DefaultFontSizeCellConstantsProtocol {
    static var cellId: String { "DefaultFontSizeCell" }
    static var sizeLabelText: String { "Font Size" }
    static var sliderMinimumValue: Float { 1.0 }
    static var minNumLabelText: String { "\(Int(self.sliderMinimumValue))" }
    static var sliderMaximimValue: Float { 100.0 }
    static var maxNumLabelText: String { "\(Int(self.sliderMaximimValue))" }
    static var numLabelWidth: CGFloat { 30.0 }
    static var sliderValue: Float { self.sliderMaximimValue / 2 }
    static var sliderValueLabelText: String { "\(Int(self.sliderValue))" }
    static var sliderStackViewSpacing: CGFloat { 15.0 }
    
    static var numLabelContentCompressionResistancePriority: UILayoutPriority { UILayoutPriority(751) }
    static var sliderContentCompressionResistancePriority: UILayoutPriority { UILayoutPriority(750) }
}

struct DefaultFontSizeCellConstants: DefaultFontSizeCellConstantsProtocol {
    
}
