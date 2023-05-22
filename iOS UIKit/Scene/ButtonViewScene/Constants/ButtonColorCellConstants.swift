//
//  ButtonColorCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import Foundation

protocol ButtonColorCellConstantsProtocol: DefaultColorCellConstantsProtocol {}

extension ButtonColorCellConstantsProtocol {
    static var cellId: String { "ButtonColorCell" }
}

struct ButtonColorCellConstants: ButtonColorCellConstantsProtocol {}
