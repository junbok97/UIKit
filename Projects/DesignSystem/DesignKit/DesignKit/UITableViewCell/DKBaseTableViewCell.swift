//
//  BaseTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 3/25/24.
//

import UIKit

public class DKBaseTableViewCell: UITableViewCell {
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttribute()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(style: .default, reuseIdentifier: nil)
        setAttribute()
        setLayout()
    }
    
    // MARK: - Func
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    func setAttribute() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    func setLayout() {}
    
    func reset() {}
    
}
