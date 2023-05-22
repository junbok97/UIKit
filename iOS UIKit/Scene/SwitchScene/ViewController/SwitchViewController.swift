//
//  SwitchViewController.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import UIKit
import RxSwift
import RxCocoa

final class SwitchViewController: DefaultListViewController {
    weak var coordinator: SwitchCoordinatorProtocol?
    private var viewModel: SwitchViewModel!
    
    static func create(
        _ viewModel: SwitchViewModel,
        _ coordinator: SwitchCoordinator
    ) -> SwitchViewController {
        let viewController = SwitchViewController()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        viewController.bind()
        return viewController
    }
    
    lazy var targetSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        return toggle
    }()
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        coordinator?.finish()
    }
    
    @objc override func didTappedLeftBarButton() {
        coordinator?.finish()
    }
    
    func bind() {
        
    }
    
    override func attribute() {
        super.attribute()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = SwitchViewControllerConstants.title
    }
    
    override func layout() {
        super.layout()
        
        containerView.addSubview(targetSwitch)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: SwitchViewControllerConstants.containerViewHeight),
            targetSwitch.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            targetSwitch.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
}
