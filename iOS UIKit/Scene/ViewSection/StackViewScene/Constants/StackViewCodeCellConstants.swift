//
//  StackViewCodeCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import Foundation

protocol StackViewCodeCellConstantsProtocol: DefaultCodeCellConstantsProtocol {
    
}

extension StackViewCodeCellConstantsProtocol {
    static var cellId: String { "StackViewCodeCell" }
}

struct StackViewCodeCellConstants: StackViewCodeCellConstantsProtocol {}
