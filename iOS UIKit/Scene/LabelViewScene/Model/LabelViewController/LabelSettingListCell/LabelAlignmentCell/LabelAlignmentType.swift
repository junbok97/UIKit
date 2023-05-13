//
//  LabelAlignmentType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/13.
//

import Foundation

import UIKit

enum LabelAlignmentType: String {
    case natural = "Natural"
    case left = "Left"
    case center = "Center"
    case right = "Right"
    case justified = "Justified"
    
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
