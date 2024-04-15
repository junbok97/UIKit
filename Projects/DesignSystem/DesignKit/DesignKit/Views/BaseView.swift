//
//  BaseView.swift
//  DesignKit
//
//  Created by 이준복 on 3/28/24.
//

import UIKit

class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        setupAttribute()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupAttribute()
    }
    
    func setupLayout() { }
    
    func setupAttribute() { }
    
}
