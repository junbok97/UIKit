//
//  StepperSettingListSectionModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/23.
//

import Foundation
import RxDataSources

struct StepperSettingListSectionModel {
    var sectionHeader: StepperSettingListSectionType
    var items: [Item]
}

extension StepperSettingListSectionModel: SectionModelType {
    typealias Item = StepperSettingListItemType
    
    init(original: StepperSettingListSectionModel, items: [StepperSettingListItemType]) {
        self = original
        self.items = items
    }
}
