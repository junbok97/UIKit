//
//  DKTitleTableSectionHeaderView.swift
//  DesignKit
//
//  Created by 이준복 on 5/25/24.
//

import UIKit

import PinLayout

public final class DKTitleTableSectionHeaderView: DKBaseTableHeaderView {
    
    public static let height: CGFloat = 50
    
    // MARK: - UI
    private let titleLabel = UILabel().then { label in
        label.text = Constants.TitleLabel.defaultText
        label.font = Constants.TitleLabel.font
    }
    
    // MARK: - View Methods
    public override func setupLayout() {
        super.setupLayout()
        
        contentView.addSubviews(titleLabel)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        titleLabel.pin.all()
    }
    
    public override func reset() {
        super.reset()
        
        titleLabel.text = Constants.TitleLabel.defaultText
    }
    
    public func setupTitle(_ title: String) {
        titleLabel.text = title
    }
    
}

// MARK: - Constants
private extension DKTitleTableSectionHeaderView {
    
    enum Constants {
        enum TitleLabel {
            enum Offset {
                static var horizontal: CGFloat { 24.0 }
                static var vertical: CGFloat { 8.0 }
            }
            
            static var defaultText: String { "Section Header Title" }
            static var font: UIFont { .boldSystemFont(ofSize: 25) }
        }
    }

}
