//
//  DKBaseViewController.swift
//  DesignKit
//
//  Created by 이준복 on 5/25/24.
//

import UIKit

public class DKBaseViewController: UIViewController {
    
    // MARK: - View Life Cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAttribte()
        setupLayout()
    }
    
    // MARK: - ViewMethods
    func setupAttribte() {
        view.backgroundColor = .systemBackground
    }
    
    func setupLayout() { }
    
}
