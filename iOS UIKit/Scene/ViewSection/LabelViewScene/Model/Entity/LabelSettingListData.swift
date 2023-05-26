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
                .code(codeType: .codeLabel),
                .code(codeType: .reloadButton)
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
                .color(colorType: .titleColor),
                .color(colorType: .backgroundColor)
            ]
        ),
        LabelSettingListSectionModel(
            sectionHeader: .font,
            items: [
                .font(fontType: .ultraLight),
                .font(fontType: .thin),
                .font(fontType: .light),
                .font(fontType: .regular),
                .font(fontType: .medium),
                .font(fontType: .semibold),
                .font(fontType: .bold),
                .font(fontType: .heavy),
                .font(fontType: .black)
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
                .alignment(alignmentType: .natural),
                .alignment(alignmentType: .left),
                .alignment(alignmentType: .center),
                .alignment(alignmentType: .right),
                .alignment(alignmentType: .justified)
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
