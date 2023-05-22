//
//  ButtonSettingListItemType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import Foundation

enum ButtonSettingListItemType {
    case code
    case buttonStyle(buttonStyle: ButtonStyleType)
    case textConfigure
    case text(titleType: ButtonTitleType)
    case font(titleType: ButtonTitleType, fontType: ObjectFontType)
    case fontSize(titleType: ButtonTitleType)
    case buttonTitleAlignment(aligmentType: ButtonTitleAlignmentType)
    case color(colorType: ButtonColorType)
    case image
    case imagePlacement(placement: ButtonImagePlacementType)
    case corner(cornerStyleType: ButtonCornerStyleType)
}
