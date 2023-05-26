//
//  SliderViewControllerConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import Foundation

protocol SliderViewControllerConstantsProtocol: DefaultListViewControllerConstantsProtocol {
    static var targetValue: Float { get }
    static var targetMaximumValue: Float { get }
    static var targetMinimumValue: Float { get }
}

extension SliderViewControllerConstantsProtocol {
    static var defaultOffset: CGFloat { 20 }
    static var title: String { "Slider" }
    static var documentURLString: String {
        "https://developer.apple.com/documentation/uikit/uislider"
    }
    static var containerViewHeight: CGFloat { 100 }
    
    static var targetValue: Float { (Self.targetMaximumValue - Self.targetMinimumValue) / 2 }
    static var targetMaximumValue: Float { 50 }
    static var targetMinimumValue: Float { 0 }
}

struct SliderViewControllerConstants: SliderViewControllerConstantsProtocol {}
