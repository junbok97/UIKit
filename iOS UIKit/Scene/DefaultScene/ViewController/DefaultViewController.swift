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
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                didTappedLeftBarButton()
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = leftBarButtonItem
        attribute()
    }
    
    func attribute() {
        view.backgroundColor = .secondarySystemBackground
        setupNavigationBar()
        setupSwipeGesture()
    }
    
}

private extension DefaultViewController {
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
    }
    
    func setupSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        view.addGestureRecognizer(swipeGesture)
    }
}
