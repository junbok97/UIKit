//
//  LabelNumberOfLinesCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/08.
//

import Foundation

protocol LabelNumberOfLinesCellConstantsProtocol: DefaultCellConstantsProtocol {
    
    static var linesLabelText: String { get }
    static var valueLabelText: String { get }
    
    static var stepperValue: Double { get }
    static var stepperMinimumValue: Double { get }
    static var stepperMaximumValue: Double { get }
    
    static var stackViewSpacing: CGFloat { get }
}

extension LabelNumberOfLinesCellConstantsProtocol {
    static var cellId: String {"LabelNumberOfLinesCell"}
    
    static var linesLabelText: String {"Lines"}
    static var valueLabelText: String { "\(LabelViewControllerConstants.targetLabelNumberOfLines)"}
    
    static var stepperValue: Double { Double(LabelViewControllerConstants.targetLabelNumberOfLines)}
    static var stepperMinimumValue: Double { 0 }
    static var stepperMaximumValue: Double { 10 }
    
    static var stackViewSpacing: CGFloat { 15 }
}

struct LabelNumberOfLinesCellConstants: LabelNumberOfLinesCellConstantsProtocol {}
