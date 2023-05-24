//
//  DefaultTextFieldCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/23.
//

import Foundation

protocol DefaultTextFieldCellConstantsProtocol: DefaultCellConstantsProtocol {
    static var placeHolder: String { get }
}

extension DefaultTextFieldCellConstantsProtocol {
    static var cellId: String { "DefaultTextFieldCell" }
    static var placeHolder: String { "textField" }
}

struct DefaultTextFieldCellConstants: DefaultTextFieldCellConstantsProtocol {
    
}
