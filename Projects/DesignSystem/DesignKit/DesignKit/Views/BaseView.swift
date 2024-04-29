//
//  BaseView.swift
//  DesignKit
//
//  Created by 이준복 on 3/28/24.
//

import UIKit

class BaseView: UIView {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAttribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAttribute()
        setupLayout()
    }
    
    
    // MARK: - Setup
    func setupAttribute() { }    
    func setupLayout() { }

}
