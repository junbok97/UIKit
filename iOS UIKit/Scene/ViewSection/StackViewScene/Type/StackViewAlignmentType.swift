//
//  StackViewAlignmentType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import UIKit

enum StackViewAlignmentType: String {
    case fill = "Fill"
    case leading = "Leading"
    case center = "Center"
    case trailing = "Trailing"
    
    var alignment: UIStackView.Alignment {
        switch self {
        case .fill:
            return .fill
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return.trailing
        }
    }
}
