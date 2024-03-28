//
//  DefaultFontCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import Foundation

protocol DefaultFontCellConstantsProtocol: DefaultCellConstantsProtocol {
    static var title: String { get }
}

extension DefaultFontCellConstantsProtocol {
    static var cellId: String { "DefaultFontCell" }
    static var title: String { "Font" }
}

struct DefaultFontCellConstants: DefaultFontCellConstantsProtocol {
    
}
