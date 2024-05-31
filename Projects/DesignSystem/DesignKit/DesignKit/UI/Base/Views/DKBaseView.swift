//
//  BaseView.swift
//  DesignKit
//
//  Created by 이준복 on 3/28/24.
//

import UIKit

public class DKBaseView: UIView {
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAttribute()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Setup
    func setupAttribute() { }    
    func setupLayout() { }

}
