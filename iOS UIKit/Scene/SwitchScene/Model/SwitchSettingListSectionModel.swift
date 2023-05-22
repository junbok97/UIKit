//
//  SwitchSettingListSectionModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import Foundation
import RxDataSources

struct SwitchSettingListSectionModel {
    var sectionHeader: SwitchSettingListSectionType
    var items: [Item]
}

extension SwitchSettingListSectionModel: SectionModelType {
    typealias Item = SwitchSettingListItemType
    
    init(original: SwitchSettingListSectionModel, items: [SwitchSettingListItemType]) {
        self = original
        self.items = items
    }
}
