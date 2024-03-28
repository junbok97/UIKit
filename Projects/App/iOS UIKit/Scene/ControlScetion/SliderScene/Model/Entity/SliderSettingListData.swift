//
//  SliderSettingListData.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/26.
//

import Foundation

struct SliderSettingListData {
    static let settingListDatas: [SliderSettingListSectionModel] = [
        SliderSettingListSectionModel(
            sectionHeader: .code,
            items: [
                .code(codeType: .codeLabel),
                .code(codeType: .reloadButton)
            ]
        ),
        
        SliderSettingListSectionModel(
            sectionHeader: .maximum,
            items: [
                .value(valueType: .maximum)
            ]
        ),
        
        SliderSettingListSectionModel(
            sectionHeader: .minimum,
            items: [
                .value(valueType: .minimum)
            ]
        ),
        
        SliderSettingListSectionModel(
            sectionHeader: .color,
            items: [
                .color(colorType: .thumbTint),
                .color(colorType: .minimumTrackTintColor),
                .color(colorType: .maximumTrackTintColor),
                .color(colorType: .background),
                .color(colorType: .tint)
            ]
        )
        
    ]
}
