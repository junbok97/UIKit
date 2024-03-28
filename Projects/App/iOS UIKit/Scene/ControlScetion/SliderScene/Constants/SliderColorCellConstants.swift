//
//  SliderColorCellConstatns.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import Foundation

protocol SliderColorCellConstatnsProtocol: DefaultColorCellConstantsProtocol {
    
}

extension SliderColorCellConstatnsProtocol {
    static var cellId: String {
        "SliderColorCell"
    }
}

struct SliderColorCellConstatns: SliderColorCellConstatnsProtocol {}
