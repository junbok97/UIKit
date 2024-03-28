//
//  ButtonSettingListItemType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import Foundation

enum ButtonSettingListItemType {
    case code(type: CodeSectionItemType)
    case buttonStyle(type: ButtonStyleType)
    case textConfigure
    case text(type: ButtonTitleType)
    case font(titleType: ButtonTitleType, fontType: ObjectFontType)
    case fontSize(type: ButtonTitleType)
    case buttonTitleAlignment(type: ButtonTitleAlignmentType)
    case color(type: ButtonColorType)
    case image
    case imagePlacement(type: ButtonImagePlacementType)
    case corner(type: ButtonCornerStyleType)
}
