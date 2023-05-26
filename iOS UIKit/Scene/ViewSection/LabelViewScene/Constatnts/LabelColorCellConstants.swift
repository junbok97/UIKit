//
//  LabelColorCellConstants.swift
//  UIKit Test
//
//  Created by 이준복 on 2023/05/08.
//

import Foundation

protocol LabelColorCellConstantsProtocol: DefaultColorCellConstantsProtocol {
}

extension LabelColorCellConstantsProtocol {
    static var cellId: String { "LabelColorCell" }
}

struct LabelColorCellConstants: LabelColorCellConstantsProtocol {
}
