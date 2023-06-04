//
//  StepperSettingListData.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import Foundation

struct StepperSettingListData {
    static let settingListData: [StepperSettingListSectionModel] = [
        StepperSettingListSectionModel(
            sectionHeader: .code,
            items: [
                .code(type: .codeLabel),
                .code(type: .reloadButton)
            ]
        ),
        StepperSettingListSectionModel(
            sectionHeader: .Stepvalue,
            items: [
                .value(type: .step)
            ]
        ),
        StepperSettingListSectionModel(
            sectionHeader: .maximum,
            items: [
                .value(type: .maximum)
            ]
        ),
        StepperSettingListSectionModel(
            sectionHeader: .minimum,
            items: [
                .value(type: .minimum)
            ]
        ),
        StepperSettingListSectionModel(
            sectionHeader: .autorepeat,
            items: [
                .toggle(type: .autorepeat)
            ]
        ),
        StepperSettingListSectionModel(
            sectionHeader: .wrap,
            items: [
                .toggle(type: .wrap)
            ]
        )
    ]
}
