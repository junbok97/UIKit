//
//  SwitchCodeCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import Foundation

protocol SwitchCodeCellConstantsProtocol: DefaultCodeCellConstantsProtocol {}

extension SwitchCodeCellConstantsProtocol {
    static var cellId: String { "SwitchCodeCellConstants" }
}

struct SwitchCodeCellConstants: SwitchCodeCellConstantsProtocol {}
