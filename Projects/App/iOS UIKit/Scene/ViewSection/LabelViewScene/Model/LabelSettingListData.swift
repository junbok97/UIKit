//
//  LabelSettingListData.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/16.
//

import Foundation

struct LabelSettingListData {
    static let settingListDatas: [LabelSettingListSectionModel] = [
        LabelSettingListSectionModel(
            sectionHeader: .code,
            items: [
                .code(type: .codeLabel),
                .code(type: .reloadButton)
            ]
        ),
        LabelSettingListSectionModel(
            sectionHeader: .text,
            items: [
                .text
            ]
        ),
        LabelSettingListSectionModel(
            sectionHeader: .color,
            items: [
                .color(type: .titleColor),
                .color(type: .backgroundColor)
            ]
        ),
        LabelSettingListSectionModel(
            sectionHeader: .font,
            items: [
                .font(type: .ultraLight),
                .font(type: .thin),
                .font(type: .light),
                .font(type: .regular),
                .font(type: .medium),
                .font(type: .semibold),
                .font(type: .bold),
                .font(type: .heavy),
                .font(type: .black)
            ]
        ),
        LabelSettingListSectionModel(
            sectionHeader: .fontSize,
            items: [
                .fontSize
            ]
        ),
        LabelSettingListSectionModel(
            sectionHeader: .alignment,
            items: [
                .alignment(type: .natural),
                .alignment(type: .left),
                .alignment(type: .center),
                .alignment(type: .right),
                .alignment(type: .justified)
            ]
        ),
        LabelSettingListSectionModel(
            sectionHeader: .numberOfLines,
            items: [
                .numberOfLines
            ]
        )
    ]
}
