//
//  StackViewSettingListData.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import Foundation

struct StackViewSettingListData {
    static let settingListDatas: [StackViewSettingListSectionModel] = [
        StackViewSettingListSectionModel(
            sectionHeader: .code,
            items: [
                .code(type: .codeLabel),
                .code(type: .reloadButton)
            ]
        ),
        StackViewSettingListSectionModel(
            sectionHeader: .axis,
            items: [
                .axis(type: .horizontal),
                .axis(type: .vertical)
            ]
        ),
        StackViewSettingListSectionModel(
            sectionHeader: .alignment,
            items: [
                .alignment(type: .fill),
                .alignment(type: .leading),
                .alignment(type: .center),
                .alignment(type: .trailing)
            ]
        ),
        StackViewSettingListSectionModel(
            sectionHeader: .distribution,
            items: [
                .distribution(type: .fill),
                .distribution(type: .fillEqually),
                .distribution(type: .fillProportionally),
                .distribution(type: .equalSpacing),
                .distribution(type: .equalCentering)
            ]
        ),
        StackViewSettingListSectionModel(
            sectionHeader: .spacing,
            items: [
                .spacing
            ]
        ),
        StackViewSettingListSectionModel(
            sectionHeader: .color,
            items: [
                .color(type: .tintColor),
                .color(type: .backgroundColor)
            ]
        )
    ]
}
