//
//  ButtonImagePlacementCase.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import UIKit

enum ButtonImagePlacementType: String {
    case all = "All"
    case top = "Top"
    case leading = "Leading"
    case trailing = "Trailing"
    case bottom = "Bottom"
    
    var imagePlacement: NSDirectionalRectEdge {
        switch self {
        case .all:
            return .all
        case .top:
            return .top
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        case .bottom:
            return .bottom
        }
    }
    
    var code: String {
        switch self {
        case .all:
            return ".all"
        case .top:
            return ".top"
        case .leading:
            return ".leading"
        case .trailing:
            return ".trailing"
        case .bottom:
            return ".bottom"
        }
    }
}
