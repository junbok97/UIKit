//
//  LabelAlignmentCellConstants.swift
//  UIKit Test
//
//  Created by 이준복 on 2023/05/08.
//

import Foundation

protocol LabelAlignmentCellConstantsProtocol: DefaultCellConstantsProtocol {
}

extension LabelAlignmentCellConstantsProtocol {
    static var cellId: String { "LabelAlignmentCell" }
}

struct LabelAlignmentCellConstants: LabelAlignmentCellConstantsProtocol {}
