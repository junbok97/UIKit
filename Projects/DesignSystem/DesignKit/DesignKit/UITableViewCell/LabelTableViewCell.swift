//
//  LabelTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 3/25/24.
//

import UIKit

import PinLayout
import Extensions

public final class LabelTableViewCell: BaseTableViewCell {
    
    // MARK: - UI
    private let label: UILabel = .init()
    
    // MARK: - Func
    
    override func setAttribute() {
        super.setAttribute()
        
        label.backgroundColor = .systemBackground
        label.text = Constants.Label.defaultText
        label.font = DefaultConstants.font
    }
    
    override func setLayout() {
        super.setLayout()
        
        contentView.addSubview(label)
        label.pin.all(DefaultConstants.inset)
    }

    
    override func reset() {
        super.reset()
        
        label.text = Constants.Label.defaultText
    }
    
    public func setupLabel(_ text: String) {
        label.text = text
    }
    
}


// MARK: - Constants
private extension LabelTableViewCell {
    
    enum Constants {
        
        enum Label {
            static var defaultText: String { "default Text" }
        }
        
    }
    
}
