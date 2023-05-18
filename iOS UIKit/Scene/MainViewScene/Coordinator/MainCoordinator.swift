//
//  MainCoordinator.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit

protocol MainCoordinatorProtocol: CoordinatorProtocol {
    func pushDetailViewController(type: ObjectType)
}

final class MainCoordinator: MainCoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol? = nil
    
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
    
    func pushDetailViewController(type: ObjectType) {
        let child = childCoordinatorFactory.makeCoordinator(type: type)
        childCoordinators.append(child)
        child.start()
    }
    
    deinit {
        print("MainCoordinator Deinit")
    }
}
