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
    case titleAlignment = "Title and SubTitle Alignment"
    case titleText = "Title Text"
    case titleFont = "Title Font"
    case titleFontSize = "Title FontSize"
    case titleForegroundColor = "Title ForegroundColor"
    case subTitleText = "SubTitle Text"
    case subTitleFont = "SubTitle Font"
    case subTitleFontSize = "SubTitle FontSize"
    case subTitleForegroundColor = "SubTitle ForegroundColor"
    case image = "Image"
    case color = "Color"
    case cornerStyle = "Corner Style"
}

enum ButtonSettingListItemType {
    case code
    case buttonType(buttonType: ButtonType)
    case buttonStyle(buttonStyle: ButtonStyleType)
    case textConfigure
    case text(titleType: ButtonTitleType)
    case font(titleType: ButtonTitleType, fontType: ObjectFontType)
    case fontSize(titleType: ButtonTitleType)
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
