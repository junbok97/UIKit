//
//  DKBaseTableHeaderView.swift
//  DesignKit
//
//  Created by 이준복 on 5/25/24.
//

import UIKit

import Extensions

class DKBaseTableHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupAttribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Life Cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    // MARK: - Setup
    func setupAttribute() { }
    func setupLayout() { }
    func reset() { }
    
}
