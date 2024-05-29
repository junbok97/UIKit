//
//  DKTextAlignmentType.swift
//  DesignKit
//
//  Created by 이준복 on 5/29/24.
//

import UIKit

public enum DKTextAlignmentType {
    
    case natural
    case left
    case center
    case right
    case justified
    
    public var title: String {
        switch self {
        case .natural: "Natural"
        case .left: "Left"
        case .center: "Center"
        case .right: "Right"
        case .justified: "Justified"
        }
    }
    
    public var aligment: NSTextAlignment {
        switch self {
        case .natural: .natural
        case .left: .left
        case .center: .center
        case .right: .right
        case .justified: .justified
        }
    }
    
    public var code: String {
        switch self {
        case .natural: ".natural"
        case .left: ".left"
        case .center: ".center"
        case .right: ".right"
        case .justified: ".justified"
        }
    }
    
}

