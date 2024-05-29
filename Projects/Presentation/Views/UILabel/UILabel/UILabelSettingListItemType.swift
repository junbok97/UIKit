//
//  UILabelSettingListItemType.swift
//  UILabel
//
//  Created by 이준복 on 5/29/24.
//

import Foundation

import DesignKit

enum UILabelSettingListItemType {
    
    case code
    case input
    case color(title: String)
    case font(type: DKFontType)
    case fontSize
    case alignment(type: DKTextAlignmentType)
    case numberOfLines
    
}
