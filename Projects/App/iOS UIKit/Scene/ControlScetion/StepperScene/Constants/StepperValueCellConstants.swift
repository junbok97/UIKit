//
//  StepperValueCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/23.
//

import Foundation

protocol StepperValueCellConstantsProtocol: DefaultTextFieldCellConstantsProtocol {}

extension StepperValueCellConstantsProtocol {
    static var cellId: String { "StepperValueCell" }
}

struct StepperValueCellConstants: StepperValueCellConstantsProtocol {}
