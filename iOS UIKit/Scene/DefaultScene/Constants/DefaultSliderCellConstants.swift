//
//  DefaultSliderCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/25.
//

import Foundation

protocol DefaultSliderCellConstantsPorotocol: DefaultCellConstantsProtocol {
    static var sliderMinimumValue: Float { get }
    static var sliderMaximimValue: Float { get }
    static var sliderValue: Float { get }
}

extension DefaultSliderCellConstantsPorotocol {
    static var cellId: String { "DefaultSliderCell" }
    static var sliderMinimumValue: Float { 1.0 }
    static var sliderMaximimValue: Float { 100.0 }
    static var sliderValue: Float { self.sliderMaximimValue / 2 }
}

struct DefaultSliderCellConstants: DefaultSliderCellConstantsPorotocol {}
