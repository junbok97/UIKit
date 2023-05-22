//
//  DefaultViewControllerConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit

protocol DefaultViewControllerConstantsProtocol {
    static var defaultFont: UIFont { get }
    static var defaultFontSize: CGFloat { get }
    static var defaultOffset: CGFloat { get }
    
    static var title: String { get }
}

extension DefaultViewControllerConstantsProtocol {
    static var defaultFont: UIFont { .systemFont(ofSize: 16) }
    static var defaultFontSize: CGFloat { 16.0 }
    static var defaultOffset: CGFloat { 12.0 }
    
    static var title: String { "Default" }
    
    static var leftBarButtontImage: UIImage? { UIImage(systemName: "chevron.backward") }
}

struct DefaultViewControllerConstants: DefaultViewControllerConstantsProtocol {
    
}
