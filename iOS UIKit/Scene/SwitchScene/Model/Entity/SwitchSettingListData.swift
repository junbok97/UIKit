//
//  SwitchSettingListData.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import Foundation

struct SwitchSettingListData {
    static let settingListDatas: [SwitchSettingListSectionModel] = [
        SwitchSettingListSectionModel(
            sectionHeader: .code,
            items: [
                .code(codeType: .codeLabel),
                .code(codeType: .reloadButton)
            ]
        ),
        SwitchSettingListSectionModel(
            sectionHeader: .color,
            items: [
                .color(colorType: .onTintColor),
                .color(colorType: .thumbTintColor),
                .color(colorType: .backgroundColor)
            ]
        )
    ]
}
