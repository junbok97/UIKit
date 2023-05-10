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
    
    lazy var factory = ChildCoordinatorFactory(parentCoordinator: self, navigationController: self.navigationController)
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewModel = MainViewModel()
        let mainViewController = MainViewController.create(mainViewModel, self)
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    func finish() {}
    
    func finishChild(_ child: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0 !== child }
        navigationController.popViewController(animated: false)
    }
    
    func showDetailViewController(type: ObjectType) {
        let child = factory.makeCoordinator(type: type)
        childCoordinators.append(child)
        child.start()
    }
    
}
