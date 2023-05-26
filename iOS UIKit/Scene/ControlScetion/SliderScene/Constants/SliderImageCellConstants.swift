//
//  SliderImageCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import Foundation

protocol SliderImageCellConstantsProtocol: DefaultLabelCellConstantsProtocol {
    
}

extension SliderImageCellConstantsProtocol {
    static var cellId: String {
        "SliderImageCell"
    }
}

struct SliderImageCellConstants: SliderImageCellConstantsProtocol {}
