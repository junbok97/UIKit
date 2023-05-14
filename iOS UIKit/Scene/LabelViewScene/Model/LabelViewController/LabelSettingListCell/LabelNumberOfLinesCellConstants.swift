//
//  LabelNumberOfLinesCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/08.
//

import Foundation

struct LabelNumberOfLinesCellConstants {
    static let cellId: String = "LabelNumberOfLinesCell"
    
    static let linesLabelText: String = "Lines"
    static let valueLabelText: String = "\(LabelViewControllerConstants.targetLabelNumberOfLines)"
    
    static let stepperValue: Double = Double(LabelViewControllerConstants.targetLabelNumberOfLines)
    static let stepperMinimumValue: Double = 0
    static let stepperMaximumValue: Double = 10
    
    static let stackViewSpacing: CGFloat = 15
}
