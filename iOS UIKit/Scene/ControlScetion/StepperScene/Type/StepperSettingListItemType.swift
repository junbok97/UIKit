//
//  StepperSettingListItemType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/23.
//

import Foundation

enum StepperSettingListItemType {
    case code(type: CodeSectionItemType)
    case value(type: StepperValueType)
    case toggle(type: StepperToggleType)
}
