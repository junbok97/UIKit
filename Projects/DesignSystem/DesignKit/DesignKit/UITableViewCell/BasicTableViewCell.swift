//
//  BasicTableViewCell.swift
//  DesignKit
//
//  Created by 이준복 on 3/25/24.
//

import UIKit

class BasicTableViewCell: UITableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(style: .default, reuseIdentifier: nil)
    }
    
    func attribute() {
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
    
    func layout() {}
    
    func reset() {}
}

