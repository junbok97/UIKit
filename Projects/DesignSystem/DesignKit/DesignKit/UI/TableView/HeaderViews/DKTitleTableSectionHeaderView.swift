//
//  DKTitleTableSectionHeaderView.swift
//  DesignKit
//
//  Created by 이준복 on 5/25/24.
//

import UIKit

import PinLayout

final class DKTitleTableSectionHeaderView: DKBaseTableHeaderView {
    
    // MARK: - UI
    private let titleLabel: UILabel = .init()
    
    // MARK: - View Methods
    override func setupAttribute() {
        super.setupAttribute()
        
        backgroundColor = .secondarySystemBackground
        
        titleLabel.text = Constants.TitleLabel.defaultText
        titleLabel.font = Constants.TitleLabel.font
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        contentView.addSubviews(titleLabel)
        titleLabel.pin
            .left(Constants.TitleLabel.Offset.horizontal)
            .right(Constants.TitleLabel.Offset.horizontal)
            .top(Constants.TitleLabel.Offset.vertical)
            .bottom(Constants.TitleLabel.Offset.vertical)
    }
    
    override func reset() {
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
