//
//  ViewControllerProtocol.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/12.
//

import UIKit

class BaseViewController: UIViewController {
    weak var coordinator: CoordinatorProtocol?
    
    class func create(_ viewModel: ViewModelProtocol, _ coordinator: CoordinatorProtocol) -> UIViewController {
        return BaseViewController()
    }
    
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let barbutton =  UIBarButtonItem(
            image:  BaseViewControllerConstants.leftBarButtontImage,
            style: .plain,
            target: self,
            action: #selector(didTappedLeftBarButton)
        )
        barbutton.tintColor = .label
        return barbutton
    }()
    
    @objc func didTappedLeftBarButton() {
        coordinator?.finish()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }
        
}
