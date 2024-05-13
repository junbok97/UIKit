//
//  DKLabelTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 3/25/24.
//

import UIKit

import PinLayout
import Extensions

public final class DKLabelTableViewCell: DKBaseTableViewCell {
    
    // MARK: - UI
    private let label: UILabel = .init()
    
    // MARK: - Func
    
    override func setAttribute() {
        super.setAttribute()
        
        label.backgroundColor = .systemBackground
        label.text = Constants.Label.defaultText
        label.font = DKDefaultConstants.font
    }
    
    override func setLayout() {
        super.setLayout()
        
        contentView.addSubview(label)
        label.pin.all(DKDefaultConstants.inset)
    }

    
    override func reset() {
        super.reset()
        
        label.text = Constants.Label.defaultText
    }
    
    public func setup(
        _ text: String,
        _ weight: UIFont.Weight = .regular,
        _ textAlignment: NSTextAlignment = .left
    ) {
        label.text = text
        label.font = .systemFont(ofSize: DKDefaultConstants.fontSize, weight: weight)
        label.textAlignment = textAlignment
    }
    
}


// MARK: - Constants
private extension DKLabelTableViewCell {
    
    enum Constants {
        
        enum Label {
            static var defaultText: String { "default Text" }
        }
        
    }
    
}
