//
//  DefaultCodeCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit

protocol DefaultCodeCellConstantsProtocol: DefaultCellConstantsProtocol {
    static var codeLabelNumberOfLines: Int { get }
    static var defaultLabelCode: String { get }
}

extension DefaultCodeCellConstantsProtocol {
    static var cellId: String { "DefaultCodeCell" }
    static var codeLabelNumberOfLines: Int { 0 }
    static var defaultLabelCode: String { "" }
}

struct DefaultCodeCellConstants: DefaultCodeCellConstantsProtocol {}
