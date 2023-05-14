//
//  ButtonCornerStyleCase.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import UIKit

enum ButtonCornerStyleType: String {
    case fixed = "Fixed"
    case dynamic = "Dynamic"
    case small = "Small"
    case medium = "Medium"
    case large = "Large"
    case capsule = "Capsule"
    
    var cornerStyle: UIButton.Configuration.CornerStyle {
        switch self {
        case .fixed:
            return .fixed
        case .dynamic:
            return .dynamic
        case .small:
            return .small
        case .medium:
            return .medium
        case .large:
            return .large
        case .capsule:
            return .capsule
        }
    }
}
