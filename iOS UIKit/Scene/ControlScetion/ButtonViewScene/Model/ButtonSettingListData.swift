//
//  ButtonSettingListData.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/16.
//

import Foundation

struct ButtonSettingListData {
    static let settingListDatas: [ButtonSettingListSectionModel] = [
        ButtonSettingListSectionModel(
            sectionHeader: .code,
            items: [
                .code(type: .codeLabel),
                .code(type: .reloadButton)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .buttonStyle,
            items: [
                .buttonStyle(type: .plain),
                .buttonStyle(type: .gray),
                .buttonStyle(type: .tinted),
                .buttonStyle(type: .filled)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .cornerStyle,
            items: [
                .corner(type: .fixed),
                .corner(type: .dynamic),
                .corner(type: .small),
                .corner(type: .medium),
                .corner(type: .large),
                .corner(type: .capsule)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .titleAlignment,
            items: [
                .buttonTitleAlignment(type: .automatic),
                .buttonTitleAlignment(type: .leading),
                .buttonTitleAlignment(type: .center),
                .buttonTitleAlignment(type: .trailing)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .titleText,
            items: [
                .text(type: .title)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .subTitleText,
            items: [
                .text(type: .subTitle)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .titleFontSize,
            items: [
                .fontSize(type: .title)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .subTitleFontSize,
            items: [
                .fontSize(type: .subTitle)
            ]
        ),
        
        ButtonSettingListSectionModel(
            sectionHeader: .titleFont,
            items: [
                .font(titleType: .title, fontType: .ultraLight),
                .font(titleType: .title, fontType: .thin),
                .font(titleType: .title, fontType: .light),
                .font(titleType: .title, fontType: .regular),
                .font(titleType: .title, fontType: .medium),
                .font(titleType: .title, fontType: .semibold),
                .font(titleType: .title, fontType: .bold),
                .font(titleType: .title, fontType: .heavy),
                .font(titleType: .title, fontType: .black)
            ]
        ),
        
        ButtonSettingListSectionModel(
            sectionHeader: .subTitleFont,
            items: [
                .font(titleType: .subTitle, fontType: .ultraLight),
                .font(titleType: .subTitle, fontType: .thin),
                .font(titleType: .subTitle, fontType: .light),
                .font(titleType: .subTitle, fontType: .regular),
                .font(titleType: .subTitle, fontType: .medium),
                .font(titleType: .subTitle, fontType: .semibold),
                .font(titleType: .subTitle, fontType: .bold),
                .font(titleType: .subTitle, fontType: .heavy),
                .font(titleType: .subTitle, fontType: .black)
            ]
        ),
        
        ButtonSettingListSectionModel(
            sectionHeader: .titleForegroundColor,
            items: [
                .color(type: .titleColor)
            ]
        ),
        
        ButtonSettingListSectionModel(
            sectionHeader: .subTitleForegroundColor,
            items: [
                .color(type: .subTitleColor)
            ]
        ),
        
        ButtonSettingListSectionModel(
            sectionHeader: .color,
            items: [
                .color(type: .tintColor),
                .color(type: .foregroundColor),
                .color(type: .backgroundColor)
            ]
        ),
        
        ButtonSettingListSectionModel(
            sectionHeader: .image,
            items: [
                .image
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .imagePlacement,
            items: [
                .imagePlacement(type: .all),
                .imagePlacement(type: .top),
                .imagePlacement(type: .leading),
                .imagePlacement(type: .trailing),
                .imagePlacement(type: .bottom)
            ]
        )
    ]
}
