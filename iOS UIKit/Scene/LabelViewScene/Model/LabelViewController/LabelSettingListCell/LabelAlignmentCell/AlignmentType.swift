//
//  AlignmentType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit

enum AlignmentType: Int, CaseIterable {
    case natural
    case left
    case center
    case right
    case justified
    
    var title: String {
        switch self {
        case .natural:
            return "Natural"
        case .left:
            return "Left"
        case .center:
            return "Center"
        case .right:
            return "Right"
        case .justified:
            return "Justified"
        }
    }
    
    var aligment: NSTextAlignment {
        switch self {
        case .natural:
            return .natural
        case .left:
            return .left
        case .center:
            return .center
        case .right:
            return .right
        case .justified:
            return .justified
        }
    }
    
    var code: String {
        switch self {
        case .natural:
            return ".natural"
        case .left:
            return ".left"
        case .center:
            return ".center"
        case .right:
            return ".right"
        case .justified:
            return ".justified"
        }
    }
}
