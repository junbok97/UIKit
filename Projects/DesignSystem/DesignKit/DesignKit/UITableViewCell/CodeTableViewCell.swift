//
//  CodeTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 3/25/24.
//

import UIKit

class CodeTableViewCell: BaseTableViewCell {
    
    // MARK: - UI
    private let codeLabel: UILabel = .init()
    
    // MARK: - Func
    override func setAttribute() {
        super.setAttribute()
        
        codeLabel.backgroundColor = .systemBackground
        codeLabel.text = Constants.CodeLabel.defaultText
        codeLabel.font = Constants.CodeLabel.font
        codeLabel.layer.cornerRadius = Constants.CodeLabel.cornerRadius
        codeLabel.clipsToBounds = true
    }
    
    override func setLayout() {
        super.setLayout()
        
    }
    
    override func reset() {
        super.reset()
        
    }
    
}


// MARK: - Constants
private extension CodeTableViewCell {
    
    enum Constants {
        
        enum CodeLabel {
            static var defaultText: String { "default" }
            static var font: UIFont { .systemFont(ofSize: 16) }
            static var cornerRadius: CGFloat { 16 }
        }
        
    }
    
}
