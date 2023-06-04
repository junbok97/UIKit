//
//  StackViewSettingListSectionItemType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import Foundation

enum StackViewSettingListItemType {
    case code(type: CodeSectionItemType)
    case axis(type: StackViewAxisType)
    case alignment(type: StackViewAlignmentType)
    case distribution(type: StackViewDistributionType)
    case spacing
    case color(type: StackViewColorType)
}
