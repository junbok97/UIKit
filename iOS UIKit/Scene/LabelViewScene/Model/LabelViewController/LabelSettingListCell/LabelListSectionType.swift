//
//  LabelListSectionType.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/12.
//

import UIKit

enum LabelListSectionType: Int, CaseIterable {
    case code
    case text
    case color
    case font
    case fontSize
    case alignment
    case numberOfLines
    
    var sectionCounts: Int {
        switch self {
        case .color:
            return LabelColorType.allCases.count
        case .font:
            return UISystemFontWeightType.allCases.count
        case .alignment:
            return AlignmentType.allCases.count
        default:
            return 1
        }
    }
    
    var sectionTitle: String {
        switch self {
        case .code:
            return "Code"
        case .text:
            return "Text"
        case .color:
            return "Color"
        case .font:
            return "Font"
        case .fontSize:
            return "FontSize"
        case .alignment:
            return "Alignment"
        case .numberOfLines:
            return "Number Of Lines"
        }
    }

}
