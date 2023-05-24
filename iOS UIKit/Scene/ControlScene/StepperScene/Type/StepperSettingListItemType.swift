//
//  StepperSettingListItemType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/23.
//

import Foundation

enum StepperSettingListItemType {
    case code(codeType: CodeSectionItemType)
    case value(valueType: StepperValueType)
    case toggle(toggleType: StepperToggleType)
}
