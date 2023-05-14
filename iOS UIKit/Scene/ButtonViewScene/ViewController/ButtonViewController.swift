//
//  ButtonViewController.swift
//  UIKit Test
//
//  Created by 이준복 on 2023/05/08.
//

import UIKit

final class ButtonViewController: DefaultViewController {
    
    weak var coordinator: ButtonCoordinatorProtocol?
    private var viewModel: ButtonViewModel!
    
    static func create(
        _ viewModel: ButtonViewModel,
        _ coordinator: ButtonCoordinatorProtocol
    ) -> ButtonViewController {
        let viewController = ButtonViewController()
        viewController.viewModel = viewModel
        viewController.coordinator = coordinator
        viewController.bind()
        return viewController
    }
    
    let targetButton: UIButton = {
        let button = UIButton()
        let config = UIButton.Configuration.filled()
        config.imagePlacement
        return button
    }()
    
    override func didTappedLeftBarButton() {
        coordinator?.finish()
    }
    
}
