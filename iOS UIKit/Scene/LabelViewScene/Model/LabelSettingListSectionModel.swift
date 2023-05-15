//
//  LabelListSectionModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/13.
//

import Foundation
import RxDataSources

enum LabelSettingListSectionType: String {
    case code = "Code"
    case text = "Text"
    case color = "Color"
    case font = "Font"
    case fontSize = "Font Size"
    case alignment = "Alignment"
    case numberOfLines = "Number Of Lines"
}

enum LabelSettingListItemType {
    case code
    case text
    case color(colorType: ObjectColorType)
    case font(fontType: ObjectFontType)
    case fontSize
    case alignment(alignmentType: ObjectAlignmentType)
    case numberOfLines
}

struct LabelSettingListSectionModel {
    var sectionHeader: LabelSettingListSectionType
    var items: [Item]
}

extension LabelSettingListSectionModel: SectionModelType {
    typealias Item = LabelSettingListItemType
    
    init(original: LabelSettingListSectionModel, items: [LabelSettingListItemType]) {
        self = original
        self.items = items
    }
}
