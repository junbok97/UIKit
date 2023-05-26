//
//  SliderCodeCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import Foundation

protocol SliderCodeCellConstantsProtocol: DefaultCodeCellConstantsProtocol {
    
}


extension SliderCodeCellConstantsProtocol {
    static var cellId: String {
        "SliderCodeCell"
    }
}

struct SliderCodeCellConstants: SliderCodeCellConstantsProtocol {}
