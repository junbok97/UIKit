//
//  DKBaseViewController.swift
//  DesignKit
//
//  Created by 이준복 on 5/25/24.
//

import UIKit

open class DKBaseViewController: UIViewController {
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        setupAttribute()
        setupLayout()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    // MARK: - ViewMethods
    open func setupAttribute() {
        view.backgroundColor = .systemBackground
    }
    
    open func setupLayout() { }
    
}
