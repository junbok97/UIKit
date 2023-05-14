//
//  LabelFontType.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/13.
//

import UIKit

enum ObjectFontType: String {
    case ultraLight = "UltraLight"
    case thin = "Thin"
    case light = "Light"
    case regular = "Regular"
    case medium = "Medium"
    case semibold = "Semibold"
    case bold = "Bold"
    case heavy = "Heavy"
    case black = "Black"
    
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
