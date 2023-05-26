//
//  SliderSettingListSectionModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import Foundation
import RxDataSources

struct SliderSettingListSectionModel {
    var sectionHeader: SliderSettingListSectionType
    var items: [Item]
}

extension SliderSettingListSectionModel: SectionModelType {
    typealias Item = SliderSettingListItemType
    
    init(original: SliderSettingListSectionModel, items: [SliderSettingListItemType]) {
        self = original
        self.items = items
    }
}
