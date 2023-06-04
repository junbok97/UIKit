//
//  StackViewCoordinator.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import UIKit

protocol StackViewCoordinatorProtocol: CoordinatorProtocol { }

final class StackViewCoordinator: StackViewCoordinatorProtocol {
    var parentCoordinator: CoordinatorProtocol?
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    
    init(
        _ navigationController: UINavigationController,
        _ parentCoordinator: CoordinatorProtocol?
    ) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let viewController = StackViewController.create(self, StackViewViewModel())
        navigationController.pushViewController(viewController, animated: true)
    }
    
    deinit {
        print("StackViewCoordinator Deinit")
    }

}
