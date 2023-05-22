//
//  SwitchColorCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import Foundation

protocol SwitchColorCellConstantsProtocol: DefaultColorCellConstantsProtocol {}

extension SwitchColorCellConstantsProtocol {
    static var cellId: String { "SwitchColorCell" }
}

struct SwitchColorCellConstants: SwitchColorCellConstantsProtocol {}
