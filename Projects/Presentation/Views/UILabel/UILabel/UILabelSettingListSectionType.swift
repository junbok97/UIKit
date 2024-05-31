//
//  UILabelSettingListSectionType.swift
//  UILabel
//
//  Created by 이준복 on 5/29/24.
//

import Foundation

enum UILabelSettingListSectionType: Int {
    
    case code
    case input
    case color
    case fontWeight
    case fontSize
    case alignment
    case numberOfLines
    
    var title: String {
        switch self {
        case .code: "Code"
        case .input: "Input"
        case .color: "Color"
        case .fontWeight: "Font Weight"
        case .fontSize: "Font Size"
        case .alignment: "Alignment"
        case .numberOfLines: "Number Of Lines"
        }
    }
    
}
