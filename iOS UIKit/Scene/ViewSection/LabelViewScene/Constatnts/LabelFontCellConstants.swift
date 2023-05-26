//
//  LabelFontCellConstants.swift
//  UIKit Test
//
//  Created by 이준복 on 2023/05/08.
//

import Foundation

protocol LabelFontCellConstantsProtocol: DefaultFontCellConstantsProtocol {
}

extension LabelFontCellConstantsProtocol {
    static var cellId: String { "LabelFontCell" }
}

struct LabelFontCellConstants: LabelFontCellConstantsProtocol {}
