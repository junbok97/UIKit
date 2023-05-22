//
//  DefaultColorCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import Foundation

protocol DefaultColorCellConstantsProtocol: DefaultCellConstantsProtocol {
    static var cellId: String { get }
    static var defaultOffset: CGFloat { get }
}

extension DefaultColorCellConstantsProtocol {
    static var defaultOffset: CGFloat { 8.0 }
}

struct DefaultColorCellConstants: DefaultColorCellConstantsProtocol {}
