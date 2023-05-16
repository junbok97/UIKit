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
                .code
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .buttonStyle,
            items: [
                .buttonStyle(buttonStyle: .plain),
                .buttonStyle(buttonStyle: .gray),
                .buttonStyle(buttonStyle: .tinted),
                .buttonStyle(buttonStyle: .filled)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .cornerStyle,
            items: [
                .corner(cornerStyleType: .fixed),
                .corner(cornerStyleType: .dynamic),
                .corner(cornerStyleType: .small),
                .corner(cornerStyleType: .medium),
                .corner(cornerStyleType: .large),
                .corner(cornerStyleType: .capsule)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .titleAlignment,
            items: [
                .buttonTitleAlignment(aligmentType: .automatic),
                .buttonTitleAlignment(aligmentType: .leading),
                .buttonTitleAlignment(aligmentType: .center),
                .buttonTitleAlignment(aligmentType: .trailing)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .titleText,
            items: [
                .text(titleType: .title)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .subTitleText,
            items: [
                .text(titleType: .subTitle)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .titleFontSize,
            items: [
                .fontSize(titleType: .title)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .subTitleFontSize,
            items: [
                .fontSize(titleType: .subTitle)
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
                .color(colorType: .titleColor)
            ]
        ),
        
        ButtonSettingListSectionModel(
            sectionHeader: .subTitleForegroundColor,
            items: [
                .color(colorType: .subTitleColor)
            ]
        ),
        
        ButtonSettingListSectionModel(
            sectionHeader: .color,
            items: [
                .color(colorType: .tintColor),
                .color(colorType: .foregroundColor),
                .color(colorType: .backgroundColor)
            ]
        ),
        
        ButtonSettingListSectionModel(
            sectionHeader: .image,
            items: [
                .image(text: ButtonImageCellConstants.labelText)
            ]
        ),
        ButtonSettingListSectionModel(
            sectionHeader: .imagePlacement,
            items: [
                .imagePlacement(placement: .all),
                .imagePlacement(placement: .top),
                .imagePlacement(placement: .leading),
                .imagePlacement(placement: .trailing),
                .imagePlacement(placement: .bottom)
            ]
        )
    ]
}
