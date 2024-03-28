//
//  StackViewLabelCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import Foundation

protocol StackViewLabelCellConstantsProtocol: DefaultLabelCellConstantsProtocol { }

extension StackViewLabelCellConstantsProtocol {
    static var cellId: String { "StackViewLabelCell" }
}
struct StackViewLabelCellConstants: StackViewLabelCellConstantsProtocol { }

