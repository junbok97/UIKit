//
//  DefaultLabelCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/15.
//

import Foundation

protocol DefaultLabelCellConstantsProtocol: DefaultCellConstantsProtocol {
}

extension DefaultLabelCellConstantsProtocol {
    static var cellId: String { "DefaultFontSizeCell" }
}

struct DefaultLabelCellConstants: DefaultLabelCellConstantsProtocol {}
