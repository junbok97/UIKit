//
//  DefaultCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import UIKit

protocol DefaultCellConstantsProtocol {
    static var cellId: String { get }
    static var defaultFont: UIFont { get }
    static var defaultOffset: CGFloat { get }
}

extension DefaultCellConstantsProtocol {
    static var cellId: String { "DefaultCell "}
    static var defaultFont: UIFont { .systemFont(ofSize: 16) }
    static var defaultOffset: CGFloat { 12.0 }
}

struct DefaultCellConstants: DefaultCellConstantsProtocol {}
