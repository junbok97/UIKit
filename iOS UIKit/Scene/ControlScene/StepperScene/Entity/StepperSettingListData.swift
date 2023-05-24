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
                .code(codeType: .codeLabel),
                .code(codeType: .reloadButton)
            ]
        ),
        StepperSettingListSectionModel(
            sectionHeader: .Stepvalue,
            items: [
                .value(valueType: .step)
            ]
        ),
        StepperSettingListSectionModel(
            sectionHeader: .maximum,
            items: [
                .value(valueType: .maximum)
            ]
        ),
        StepperSettingListSectionModel(
            sectionHeader: .minimum,
            items: [
                .value(valueType: .minimum)
            ]
        ),
        StepperSettingListSectionModel(
            sectionHeader: .autorepeat,
            items: [
                .toggle(toggleType: .autorepeat)
            ]
        ),
        StepperSettingListSectionModel(
            sectionHeader: .wrap,
            items: [
                .toggle(toggleType: .wrap)
            ]
        ),


    ]
}
