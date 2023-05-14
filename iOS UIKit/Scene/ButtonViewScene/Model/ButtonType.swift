//
//  ButtonTypeCase.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import UIKit

enum ButtonType: String {
    case custom = "Custom"
    case system = "System"
    case detailDisclosure = "DetailDisclosure"
    case infoLight = "InfoLight"
    case infoDark = "InfoDark"
    case contactAdd = "ContactAdd"
    case close = "Close"
    
    var type: UIButton.ButtonType {
        switch self {
        case .custom:
            return .custom
        case .system:
            return .system
        case .detailDisclosure:
            return .detailDisclosure
        case .infoLight:
            return .infoLight
        case .infoDark:
            return .infoDark
        case .contactAdd:
            return .contactAdd
        case .close:
            return .close
        }
    }
}
