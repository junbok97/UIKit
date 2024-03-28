//
//  ButtonStyleCase.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import UIKit

enum ButtonStyleType: String {
    case plain = "Plain"
    case gray = "Gray"
    case tinted = "Tinted"
    case filled = "Filled"
    
    var style: UIButton.Configuration {
        switch self {
        case .plain:
            return .plain()
        case .gray:
            return .gray()
        case .tinted:
            return .tinted()
        case .filled:
            return .filled()
        }
    }
    
    var code: String {
        switch self {
        case .plain:
            return "UIButton.Configuration.plain()"
        case .gray:
            return "UIButton.Configuration.gray()"
        case .tinted:
            return "UIButton.Configuration.tinted()"
        case .filled:
            return "UIButton.Configuration.filled()"
        }
    }
}
