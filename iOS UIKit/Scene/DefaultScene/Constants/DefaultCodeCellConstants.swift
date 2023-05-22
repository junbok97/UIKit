//
//  DefaultCodeCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit

protocol DefaultCodeCellConstantsProtocol: DefaultCellConstantsProtocol {
}

extension DefaultCodeCellConstantsProtocol {
    static var cellId: String { "DefaultCodeCell" }
}

struct DefaultCodeCellConstants: DefaultCodeCellConstantsProtocol {
}
