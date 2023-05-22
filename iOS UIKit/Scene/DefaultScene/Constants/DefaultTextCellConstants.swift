//
//  DefaultTextCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import Foundation

protocol DefaultTextCellConstantsProtocol: DefaultCellConstantsProtocol {
    static var text: String { get }
}

extension DefaultTextCellConstantsProtocol {
    static var cellId: String { "DefaultTextCell" }
    static var text: String { "Text" }
}

struct DefaultTextCellConstants: DefaultTextCellConstantsProtocol {}
