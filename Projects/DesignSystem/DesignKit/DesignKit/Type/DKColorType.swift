//
//  DKColorType.swift
//  DesignKit
//
//  Created by 이준복 on 5/30/24.
//

import Foundation

public enum DKColorType {
    
    case text
    case foreground
    case background
    case tint
    
    public var title: String {
        switch self {
        case .text:
            return "Text Color"
        case .background:
            return "Background Color"
        case .foreground:
            return "Foreground Color"
        case .tint:
            return "Tint Color"
        }
    }
    
}
