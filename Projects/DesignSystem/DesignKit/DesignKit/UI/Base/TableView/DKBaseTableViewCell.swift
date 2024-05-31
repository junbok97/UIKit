//
//  DKBaseTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 3/25/24.
//

import UIKit

public class DKBaseTableViewCell: UITableViewCell {
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAttribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Life Cycle
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    // MARK: - View Methods
    func setupAttribute() {
        reset()
        
        backgroundColor = .systemBackground
        selectionStyle = .none
        separatorInset = .zero
    }
    
    func setupLayout() {}
    func reset() {}
    
}
