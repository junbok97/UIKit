//
//  ButtonTitleFontCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import Foundation

protocol ButtonFontCellConstantsProtocol: DefaultFontCellConstantsProtocol {}

extension ButtonFontCellConstantsProtocol {
    static var cellId: String { "ButtonFontCell" }
}

struct ButtonFontCellConstants: ButtonFontCellConstantsProtocol { }
