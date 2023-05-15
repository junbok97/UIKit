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
    case textConfigure = "Text Configure"
    case text = "Text"
    case textAlignment = "Text Alignment"
    case textFont = "Text Font"
    case textFontSize = "Text FontSize"
    case image = "Image"
    case color = "Color"
    case cornerStyle = "Corner Style"
}

enum ButtonSettingListItemType {
    case code
    case buttonType(buttonType: ButtonType)
    case buttonStyle(buttonStyle: ButtonStyleType)
    case textConfigure
    case text
    case font(fontType: ObjectFontType)
    case fontSize
    case buttonTitleAlignment(aligmentType: ButtonTitleAlignmentType)
    case color(colorType: ObjectColorType)
    case image(text: String)
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
