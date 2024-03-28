//
//  LabelSettingListItemType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import Foundation

enum LabelSettingListItemType {
    case code(type: CodeSectionItemType)
    case text
    case color(type: LabelColorType)
    case font(type: ObjectFontType)
    case fontSize
    case alignment(type: ObjectAlignmentType)
    case numberOfLines
}
