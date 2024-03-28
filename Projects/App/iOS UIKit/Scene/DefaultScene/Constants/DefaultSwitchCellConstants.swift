//
//  DefaultSwitchCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/20.
//

import Foundation

protocol DefaultSwitchCellConstantsProtocol: DefaultCellConstantsProtocol {
    static var stackViewSpacing: CGFloat { get }
}

extension DefaultSwitchCellConstantsProtocol {
    static var cellId: String { "DefaultSwitchCell" }
    static var stackViewSpacing: CGFloat { 15.0 }
}

struct DefaultSwitchCellConstants: DefaultSwitchCellConstantsProtocol {}
