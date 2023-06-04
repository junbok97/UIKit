//
//  StackViewAxisType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import UIKit

enum StackViewAxisType: String {
    case horizontal = "Horizontal"
    case vertical = "Vertical"
    
    var axis: NSLayoutConstraint.Axis {
        switch self {
        case .horizontal:
            return NSLayoutConstraint.Axis.horizontal
        case .vertical:
            return NSLayoutConstraint.Axis.vertical
        }
    }
    
    var code: String {
        switch self {
        case .horizontal:
            return ".horizontal"
        case .vertical:
            return ".vertical"
        }
    }
}
