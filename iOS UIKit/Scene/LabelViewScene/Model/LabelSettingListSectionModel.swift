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

enum LabelSettingListSectionItemType {
    case codeSectionItem
    case textSectionItem
    case colorSectionItem(colorType: ObjectColorType)
    case fontSectionItem(fontType: ObjectFontType)
    case fontSizeSectionItem
    case alignmentSectionItem(alignmentType: ObjectAlignmentType)
    case numberOfLinesSectionItem
}

struct LabelSettingListSectionModel {
    var sectionHeader: LabelSettingListSectionType
    var items: [Item]
}

extension LabelSettingListSectionModel: SectionModelType {
    typealias Item = LabelSettingListSectionItemType
    
    init(original: LabelSettingListSectionModel, items: [LabelSettingListSectionItemType]) {
        self = original
        self.items = items
    }
}
