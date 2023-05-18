//
//  DefaultViewController.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/17.
//

import Foundation
import RxSwift
import RxDataSources

class DefaultViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let barbutton =  UIBarButtonItem(
            image: DefaultViewControllerConstants.leftBarButtontImage,
            style: .plain,
            target: self,
            action: #selector(didTappedLeftBarButton)
        )
        barbutton.tintColor = .label
        return barbutton
    }()
    
    @objc func didTappedLeftBarButton() { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = leftBarButtonItem
        attribute()
    }
    
    func attribute() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.standardAppearance = UINavigationBarAppearance()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
}
