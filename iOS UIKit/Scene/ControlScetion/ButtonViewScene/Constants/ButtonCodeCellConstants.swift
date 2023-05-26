//
//  ButtonCodeCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import Foundation

protocol ButtonCodeCellConstantsProtocol: DefaultCodeCellConstantsProtocol {}

extension ButtonCodeCellConstantsProtocol {
    static var cellId: String { "ButtonCodeCell" }
}

struct ButtonCodeCellConstants: ButtonCodeCellConstantsProtocol {}
