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
    
    // MARK: - View Methods
    override func setAttribute() {
        super.setAttribute()
        
        label.backgroundColor = .systemBackground
        label.text = Constants.Label.defaultText
        label.font = DKDefaultConstants.font
        label.numberOfLines = Constants.Label.numberOfLines
    }
    
    override func setLayout() {
        super.setLayout()
        
        contentView.addSubview(label)
        label.pin.all(DKDefaultConstants.padding)
    }

    
    override func reset() {
        super.reset()
        
        label.text = Constants.Label.defaultText
    }
    
    public func setup(
        _ text: String,
        _ ofSize: CGFloat = DKDefaultConstants.fontSize,
        _ weight: UIFont.Weight = .regular,
        _ textAlignment: NSTextAlignment = .left
    ) {
        label.text = text
        label.font = .systemFont(ofSize: ofSize, weight: weight)
        label.textAlignment = textAlignment
    }
    
}

// MARK: - Constants
private extension DKLabelTableViewCell {
    
    enum Constants {
        enum Label {
            static var numberOfLines: Int { 0 }
            static var defaultText: String { "default Text" }
        }
    }
    
}
