//
//  StepperToggleCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import Foundation

protocol StepperToggleCellConstantsProtocol: DefaultSwitchCellConstantsProtocol {}

extension StepperToggleCellConstantsProtocol {
    static var cellId: String {
        "StepperToggleCellConstants"
    }
}

struct StepperToggleCellConstants: StepperToggleCellConstantsProtocol {}
