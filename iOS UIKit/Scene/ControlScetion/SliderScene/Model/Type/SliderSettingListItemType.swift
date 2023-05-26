//
//  SliderSettingListItemType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import Foundation

enum SliderSettingListItemType {
    case code(codeType: CodeSectionItemType)
    case value(valueType: SliderValueType)
    case color(colorType: SliderColorType)
}
