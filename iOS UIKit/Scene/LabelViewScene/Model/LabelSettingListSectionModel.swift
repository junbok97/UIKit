//
//  LabelListSectionModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/13.
//

import Foundation
import RxDataSources

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
