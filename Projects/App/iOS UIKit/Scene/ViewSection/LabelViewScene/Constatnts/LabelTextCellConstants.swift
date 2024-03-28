//
//  LabelTextCellConstants.swift
//  UIKit Test
//
//  Created by 이준복 on 2023/05/08.
//

import Foundation

protocol LabelTextCellConstantsProtocol: DefaultCellConstantsProtocol {
}

extension LabelTextCellConstantsProtocol {
    static var cellId: String { "LabelTextCell" }
}

struct LabelTextCellConstants: LabelTextCellConstantsProtocol { }
