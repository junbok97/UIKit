//
//  LabelCoordinator.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/12.
//

import UIKit

protocol LabelCoordinatorProtocol: CoordinatorProtocol {
    var parentCoordinator: MainCoordinator? { get }
    func finish()
}

final class LabelCoordinator: LabelCoordinatorProtocol {
    var parentCoordinator: MainCoordinator?
    var navigationController: UINavigationController
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = LabelViewModel()
        let viewController = LabelViewController.create(viewModel, self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func finish() {
        parentCoordinator?.finishChild(self)
    }
}
