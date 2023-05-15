//
//  ButtonSettingListSectionType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/15.
//

import Foundation
import RxDataSources

enum ButtonSettingListSectionType: String {
    case code = "Code"
    case buttonType = "Button Type"
    case buttonStyle = "Button Style"
    case titleText = "Title Text"
    case titleFont = "Title Font"
    case titleFontSize = "Title FontSize"
    case subTitleText = "SubTitle Text"
    case subtitleFont = "SubTitle Font"
    case subtitleFontSize = "SubTitle FontSize"
    case image = "Image"
    case color = "Color"
    case cornerStyle = "Corner Style"
}

enum ButtonSettingListItemType {
    case code
    case buttonType(buttonType: ButtonType)
    case buttonStyle(buttonStyle: ButtonStyleType)
    case text
    case font(fontType: ObjectFontType)
    case fontSize
    case buttonTitleAlignment(aligmentType: ButtonTitleAlignmentType)
    case color(colorType: ObjectColorType)
    case image
    case corner(cornerStyleType: ButtonCornerStyleType)
}

struct ButtonSettingListSectionModel {
    var sectionHeader: ButtonSettingListSectionType
    var items: [Item]
}

extension ButtonSettingListSectionModel: SectionModelType {
    typealias Item = ButtonSettingListItemType
    
    init(original: ButtonSettingListSectionModel, items: [ButtonSettingListItemType]) {
        self = original
        self.items = items
    }
}
