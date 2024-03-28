//
//  StackViewControllerConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import UIKit

protocol StackViewControllerConstantsProtocol: DefaultViewControllerConstantsProtocol {
    static var objectFontSize: UIFont { get }
    static var firstObjectTitle: String { get }
    static var firstObjectBackgroundColor: UIColor { get }
    static var secondObjectTitle: String { get }
    static var secondObjectBackgroundColor: UIColor { get }
    static var thirdObjectTitle: String { get }
    static var thirdObjectBackgroundColor: UIColor { get }
    
    static var targetAxis: StackViewAxisType { get }
    static var targetSpacing: CGFloat { get }
    static var targetAlignment: StackViewAlignmentType { get }
    static var targetDistribution: StackViewDistributionType { get }
    
}

extension StackViewControllerConstantsProtocol {
    static var title: String { "StackView" }
    static var documentURLString: String {
        "https://developer.apple.com/documentation/uikit/uistackview"
    }

    static var targetAxis: StackViewAxisType { .vertical }
    static var targetSpacing: CGFloat { 5.0 }
    static var targetAlignment: StackViewAlignmentType { .fill }
    static var targetDistribution: StackViewDistributionType { .fillEqually }
    
    static var objectFontSize: UIFont { .boldSystemFont(ofSize: 20) }
    static var firstObjectTitle: String { "First" }
    static var firstObjectBackgroundColor: UIColor { .systemGray5 }
    static var secondObjectTitle: String {  "Second"  }
    static var secondObjectBackgroundColor: UIColor { .systemGray3 }
    static var thirdObjectTitle: String {  "Third"  }
    static var thirdObjectBackgroundColor: UIColor { .systemGray }
    
    
}

struct StackViewControllerConstants: StackViewControllerConstantsProtocol { }
