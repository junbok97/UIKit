//
//  LabelListSectionCase.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/12.
//

import UIKit

enum LabelListSectionCase: Int, CaseIterable {
    case text
    case color
    case font
    case fontSize
    case alignment
    case numberOfLines
    case code
    
    var sectionCounts: Int {
        switch self {
        case .color:
            return LabelColorCase.allCases.count
        case .font:
            return UISystemFontWeightCase.allCases.count
        case .alignment:
            return AlignmentCase.allCases.count
        default:
            return 1
        }
    }
    
    var sectionTitle: String {
        switch self {
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
        case .code:
            return "Code"
        }
    }

}
