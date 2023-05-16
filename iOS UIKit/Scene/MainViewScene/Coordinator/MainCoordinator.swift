//
//  MainCoordinator.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit

protocol MainCoordinatorProtocol: CoordinatorProtocol {
    func finishChild(_ child: CoordinatorProtocol)
    func showDetailViewController(type: ObjectType)
}

final class MainCoordinator: MainCoordinatorProtocol {
    
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    
    private lazy var childCoordinatorFactory = ChildCoordinatorFactory(
        parentCoordinator: self,
        navigationController: self.navigationController
    )
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MainViewModel()
        let viewController = MainViewController.create(viewModel, self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func finish() {}
    
    func finishChild(_ child: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0 !== child }
        navigationController.popViewController(animated: false)
    }
    
    func showDetailViewController(type: ObjectType) {
        let child = childCoordinatorFactory.makeCoordinator(type: type)
        childCoordinators.append(child)
        child.start()
    }
    
    deinit {
        print("MainCoordinator Deinit")
    }
}
