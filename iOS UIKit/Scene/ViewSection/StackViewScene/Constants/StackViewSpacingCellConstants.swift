//
//  StackViewSpacingCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import Foundation

protocol StackViewSpacingCellConstantsProtocol: DefaultTextFieldCellConstantsProtocol {
    
}

extension StackViewSpacingCellConstantsProtocol {
    static var cellId: String { "StackViewSpacingCell" }
}

struct StackViewSpacingCellConstants: StackViewSpacingCellConstantsProtocol { }
