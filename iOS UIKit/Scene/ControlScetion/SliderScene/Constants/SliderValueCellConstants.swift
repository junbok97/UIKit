//
//  SliderValueCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/26.
//

import Foundation

protocol SliderValueCellConstantsProtocol: DefaultTextFieldCellConstantsProtocol {
    
}

extension SliderValueCellConstantsProtocol {
    static var cellId: String {
        "SliderValueCell"
    }
}

struct SliderValueCellConstants: SliderValueCellConstantsProtocol {}
