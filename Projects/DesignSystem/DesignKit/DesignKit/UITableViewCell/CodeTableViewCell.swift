//
//  CodeTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 3/25/24.
//

import UIKit

import PinLayout
import Extensions

public final class CodeTableViewCell: BaseTableViewCell {
    
    // MARK: - UI
    private let codeLabel: UILabel = .init()
    
    // MARK: - Func
    
    override func setAttribute() {
        super.setAttribute()
        
        codeLabel.backgroundColor = .systemBackground
        codeLabel.text = Constants.CodeLabel.defaultText
        codeLabel.font = DefaultConstants.font
    }
    
    override func setLayout() {
        super.setLayout()
        
        contentView.addSubview(codeLabel)
        codeLabel.pin.all(DefaultConstants.inset)
    }

    
    override func reset() {
        super.reset()
        
        codeLabel.text = Constants.CodeLabel.defaultText
    }
    
    public func setupCodeLabel(_ codeString: String) {
        codeLabel.text = codeString
    }
    
}


// MARK: - Constants
private extension CodeTableViewCell {
    
    enum Constants {
        
        enum CodeLabel {
            static var defaultText: String { "default Code" }
        }
        
    }
    
}
