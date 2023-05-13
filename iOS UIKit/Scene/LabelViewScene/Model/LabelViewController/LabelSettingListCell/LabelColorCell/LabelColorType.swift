//
//  LabelColorCase.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/12.
//

import Foundation

enum LabelColorType: Int, CaseIterable {
    case textColor
    case backgroundColor
    
    var title: String {
        switch self {
        case .textColor:
            return "TextColor"
        case .backgroundColor:
            return "BackgroundColor"
        }
    }
}
