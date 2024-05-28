//
//  DKFontWeight.swift
//  DesignKit
//
//  Created by 이준복 on 5/13/24.
//

import UIKit

public enum DKFontWeight {
    
    case ultraLight
    case thin
    case light
    case regular
    case medium
    case semibold
    case bold
    case heavy
    case black
    
    public var title: String {
        switch self {
        case .ultraLight: "UltraLight"
        case .thin: "Thin"
        case .light: "Light"
        case .regular: "Regular"
        case .medium: "Medium"
        case .semibold: "Semibold"
        case .bold: "Bold"
        case .heavy: "Heavy"
        case .black: "Black"
        }
    }
    
    private var type: String {
        switch self {
        case .ultraLight: ".ultraLight"
        case .thin: ".thin"
        case .light: ".light"
        case .regular: ".regular"
        case .medium: ".medium"
        case .semibold: ".semibold"
        case .bold: ".bold"
        case .heavy: ".heavy"
        case .black: ".black"
        }
    }
    
    public func font(ofSize: CGFloat) -> UIFont {
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
    
    public func code(ofSize: CGFloat) -> String {
        """
        .systemFont(
            ofSize: \(ofSize),
            weight: \(type)
        )
        """
    }
    
}
