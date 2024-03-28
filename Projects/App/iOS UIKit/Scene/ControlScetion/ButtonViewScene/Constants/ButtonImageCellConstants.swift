//
//  ButtonImageCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/15.
//

import Foundation

protocol ButtonImageCellConstantsProtocol: DefaultLabelCellConstantsProtocol {}

extension ButtonImageCellConstantsProtocol {
    static var cellId: String { "ButtonImageCell" }
    static var labelText: String { "SF Symbols Select" }
}

struct ButtonImageCellConstants: ButtonImageCellConstantsProtocol {
}
