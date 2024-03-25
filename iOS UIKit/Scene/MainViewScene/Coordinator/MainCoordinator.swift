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
    var parentCoordinator: CoordinatorProtocol?
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    
    private lazy var childCoordinatorFactory = ChildCoordinatorFactory(self, self.navigationController)
    
    init(
        _ navigationController: UINavigationController,
        _ parentCoordinator: CoordinatorProtocol?
    ) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
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
    
}
