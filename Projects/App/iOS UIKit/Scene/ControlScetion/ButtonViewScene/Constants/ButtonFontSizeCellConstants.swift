//
//  ButtonFontSizeCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/16.
//

import Foundation

protocol ButtonFontSizeCellConstantsProtocol: DefaultFontSizeCellConstantsProtocol { }

extension ButtonFontSizeCellConstantsProtocol {
    static var cellId: String { "ButtonFontSizeCell" }
    
    static var sliderMaximimValue: Float { 50 }
    static var sliderValue: Float { 25 }
}

struct ButtonFontSizeCellConstants: ButtonFontSizeCellConstantsProtocol { }
