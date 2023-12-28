//
//  StackSettingListSectionModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import Foundation
import RxDataSources

struct StackViewSettingListSectionModel: SectionModelType {
    var sectionHeader: StackViewSettingListSectionType
    var items: [Item]
}

extension StackViewSettingListSectionModel {
    typealias Item = StackViewSettingListItemType
    
    init(
        original: StackViewSettingListSectionModel,
        items: [Item]
    ) {
        self = original
        self.items = items
    }
}
