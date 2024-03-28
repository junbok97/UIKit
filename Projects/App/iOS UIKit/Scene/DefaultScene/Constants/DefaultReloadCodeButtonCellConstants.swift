//
//  DefaultReloadCodeButtonCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/23.
//

import Foundation

protocol DefaultReloadCodeButtonCellConstantsProtocol: DefaultCellConstantsProtocol {
    static var buttonTitle: String { get }
    static var section: Int { get }
}

extension DefaultReloadCodeButtonCellConstantsProtocol {
    static var cellId: String { "DefaultReloadCodeButtonCell" }
    static var buttonTitle: String { "Reload Code" }
    static var section: Int { 0 }
}

struct DefaultReloadCodeButtonCellConstants: DefaultReloadCodeButtonCellConstantsProtocol {}
