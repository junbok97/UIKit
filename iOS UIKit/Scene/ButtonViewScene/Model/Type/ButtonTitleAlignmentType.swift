//
//  ButtonTitleAlignmentType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/15.
//

import UIKit

enum ButtonTitleAlignmentType: String {
    case automatic = "Automatic"
    case leading = "Leading"
    case center = "Center"
    case trailing = "Trailing"
    
    var alignment: UIButton.Configuration.TitleAlignment {
        switch self {
        case .automatic:
            return .automatic
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        }
    }
}
