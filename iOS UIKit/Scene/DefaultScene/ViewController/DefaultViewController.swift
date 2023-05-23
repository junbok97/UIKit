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
        let barButton = UIBarButtonItem(
            image: DefaultViewControllerConstants.leftBarButtontImage,
            style: .plain,
            target: self,
            action: #selector(didTappedLeftBarButton)
        )
        barButton.tintColor = .label
        return barButton
    }()
    
    private lazy var rightBatButtonItem: UIBarButtonItem = {
        let barButton = UIBarButtonItem(
            image: DefaultViewControllerConstants.rightBarButtontImage,
            style: .plain,
            target: self,
            action: #selector(didTappedRightBarButton)
        )
        barButton.tintColor = .label
        return barButton
    }()
    
    func getDocumentURLString() -> String {
        DefaultViewControllerConstants.documentURLString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
    }
    
    func attribute() {
        view.backgroundColor = .secondarySystemBackground
        setupNavigationBar()
        setupSwipeGesture()
    }
    
    @objc func didTappedLeftBarButton() { }
    
}

private extension DefaultViewController {
    @objc func didTappedRightBarButton() {
        if let url = URL(string: self.getDocumentURLString()) {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
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
    
    func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.compactScrollEdgeAppearance = appearance
        
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.rightBarButtonItem = rightBatButtonItem
    }
    
    func setupSwipeGesture() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        view.addGestureRecognizer(swipeGesture)
    }
}
