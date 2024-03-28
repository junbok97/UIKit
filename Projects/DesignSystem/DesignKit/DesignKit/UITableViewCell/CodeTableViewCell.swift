//
//  CodeTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 3/25/24.
//

import UIKit

class CodeTableViewCell: BasicTableViewCell {
    
    private let codeLabel: UILabel = .init()
    
    override func attribute() {
        super.attribute()
        
        codeLabel.backgroundColor = .systemBackground
        codeLabel.textColor = .label
        codeLabel.font = Constants.CodeLabel.font
        codeLabel.numberOfLines = Constants.CodeLabel.numberOfLines
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func layout() {
        super.layout()
        contentView.addSubview(codeLabel)
    }
    
    override func reset() {
        super.reset()
        codeLabel.text = ""
    }
    
}



private extension CodeTableViewCell {
    
    enum Constants {
        enum CodeLabel {
            static let font: UIFont = .systemFont(ofSize: 16)
            static let numberOfLines = 0
        }
    }
    
}
