//
//  ButtonLabelCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/15.
//

import Foundation

protocol ButtonLabelCellConstantsProtocol: DefaultLabelCellConstantsProtocol {}

extension ButtonLabelCellConstantsProtocol {
    static var cellId: String { "ButtonLabelCell" }
}

struct ButtonLabelCellConstants: ButtonLabelCellConstantsProtocol {}
