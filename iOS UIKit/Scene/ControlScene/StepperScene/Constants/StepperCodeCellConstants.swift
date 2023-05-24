//
//  StepperCodeCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import Foundation

protocol StepperCodeCellConstantsProtocol: DefaultCodeCellConstantsProtocol {}

extension StepperCodeCellConstantsProtocol {
    static var cellId: String {
        "StepperCodeCell"
    }
}

struct StepperCodeCellConstants: StepperCodeCellConstantsProtocol {}
