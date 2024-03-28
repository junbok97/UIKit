//
//  StackViewCodeCellConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import Foundation

protocol StackViewCodeCellConstantsProtocol: DefaultCodeCellConstantsProtocol {
    
}

extension StackViewCodeCellConstantsProtocol {
    static var cellId: String { "StackViewCodeCell" }
    static var defaultLabelCode: String {
        """
        let objects: [UILabel] = [first, second, third]
        
        lazy var stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: objects)
            
            stackView.axis = \(StackViewControllerConstants.targetAxis.code)
            stackView.spacing = \(String(format: "%lf", StackViewControllerConstants.targetSpacing))
            stackView.alignment = \(StackViewControllerConstants.targetAlignment.code)
            stackView.distribution = \(StackViewControllerConstants.targetDistribution.code)
            stackView.tintColor = nil
            stackView.backgroundColor = nil
            
            return stackView
        }()
        """
    }
}

struct StackViewCodeCellConstants: StackViewCodeCellConstantsProtocol {}
