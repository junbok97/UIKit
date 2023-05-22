//
//  LabelSettingListItemType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import Foundation

enum LabelSettingListItemType {
    case code
    case text
    case color(colorType: LabelColorType)
    case font(fontType: ObjectFontType)
    case fontSize
    case alignment(alignmentType: ObjectAlignmentType)
    case numberOfLines
}
