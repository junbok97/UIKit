//
//  LabelFontSizeCellConstants.swift
//  UIKit Test
//
//  Created by 이준복 on 2023/05/08.
//

import UIKit

protocol LabelFontSizeCellConstantsProtocol: DefaultFontSizeCellConstantsProtocol {
}

extension LabelFontSizeCellConstantsProtocol {
    static var cellId: String { "LabelFontSizeCell" }
}

struct LabelFontSizeCellConstants: LabelFontSizeCellConstantsProtocol {}
