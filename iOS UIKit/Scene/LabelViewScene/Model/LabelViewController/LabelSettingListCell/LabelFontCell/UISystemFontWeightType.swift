//
//  UISystemFontWeightCase.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit

enum UISystemFontWeightType: Int, CaseIterable {
    case ultraLight
    case thin
    case light
    case regular
    case medium
    case semibold
    case bold
    case heavy
    case black
    
    var title: String {
        switch self {
        case .ultraLight:
            return "UltraLight"
        case .thin:
            return "Thin"
        case .light:
            return "Light"
        case .regular:
            return "Regular"
        case .medium:
            return "Medium"
        case .semibold:
            return "Semibold"
        case .bold:
            return "Bold"
        case .heavy:
            return "Heavy"
        case .black:
            return "Black"
        }
    }
    
    func font(ofSize: CGFloat) -> UIFont {
        switch self {
        case .ultraLight:
            return .systemFont(ofSize: ofSize, weight: .ultraLight)
        case .thin:
            return .systemFont(ofSize: ofSize, weight: .thin)
        case .light:
            return .systemFont(ofSize: ofSize, weight: .light)
        case .regular:
            return .systemFont(ofSize: ofSize, weight: .regular)
        case .medium:
            return .systemFont(ofSize: ofSize, weight: .medium)
        case .semibold:
            return .systemFont(ofSize: ofSize, weight: .semibold)
        case .bold:
            return .systemFont(ofSize: ofSize, weight: .bold)
        case .heavy:
            return .systemFont(ofSize: ofSize, weight: .heavy)
        case .black:
            return .systemFont(ofSize: ofSize, weight: .black)
        }
    }
    
    func code(ofSize: CGFloat) -> String {
        switch self {
        case .ultraLight:
            return ".systemFont(ofSize: \(ofSize), weight: .ultraLight)"
        case .thin:
            return ".systemFont(ofSize: \(ofSize), weight: .thin)"
        case .light:
            return ".systemFont(ofSize: \(ofSize), weight: .light)"
        case .regular:
            return ".systemFont(ofSize: \(ofSize), weight: .regular)"
        case .medium:
            return ".systemFont(ofSize: \(ofSize), weight: .medium)"
        case .semibold:
            return ".systemFont(ofSize: \(ofSize), weight: .semibold)"
        case .bold:
            return ".systemFont(ofSize: \(ofSize), weight: .bold)"
        case .heavy:
            return ".systemFont(ofSize: \(ofSize), weight: .heavy)"
        case .black:
            return ".systemFont(ofSize: \(ofSize), weight: .black)"
        }
    }
    
}
