//
//  DKBaseTableHeaderView.swift
//  DesignKit
//
//  Created by 이준복 on 5/25/24.
//

import UIKit

import Extensions

public class DKBaseTableHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Init
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupAttribute()
        setupLayout()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Life Cycle
    public override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    // MARK: - Setup
    public func setupAttribute() { 
        contentView.backgroundColor = .secondarySystemBackground
    }
    public func setupLayout() { }
    public func reset() { }
    
}
