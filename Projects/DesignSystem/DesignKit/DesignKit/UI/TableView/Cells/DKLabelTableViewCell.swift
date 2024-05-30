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
    override func setupAttribute() {
        super.setupAttribute()
        
        label.backgroundColor = .systemBackground
        label.font = DKDefaultConstants.font
        label.numberOfLines = Constants.Label.numberOfLines
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        contentView.addSubview(label)
    }

    override func reset() {
        super.reset()
        
        label.text = Constants.Label.defaultText
    }
    
    
    // MARK: - View Drawing Cycle
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        label.pin.all(DKDefaultConstants.padding)
    }
    
    // MARK: - Logic
    public func setup(
        text: String,
        ofSize: CGFloat = DKDefaultConstants.fontSize,
        weight: UIFont.Weight = .regular,
        textAlignment: NSTextAlignment = .left
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
