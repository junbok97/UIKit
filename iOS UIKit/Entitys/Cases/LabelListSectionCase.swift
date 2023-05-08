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
    case alignment
    
    var sectionCounts: Int {
        switch self {
        case .text:
            return 1
        case .color:
            return LabelColorCase.allCases.count
        case .font:
            return UISystemFontWeightCase.allCases.count
        case .alignment:
            return AlignmentCase.allCases.count
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
        case .alignment:
            return "Alignment"
        }
    }

}
