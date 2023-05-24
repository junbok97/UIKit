//
//  ButtonSettingListSectionModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/15.
//

import Foundation
import RxDataSources

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
