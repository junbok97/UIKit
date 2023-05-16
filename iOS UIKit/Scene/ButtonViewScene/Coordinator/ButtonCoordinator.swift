//
//  ButtonCoordinator.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit

protocol ButtonCoordinatorProtocol: CoordinatorProtocol {
    var parentCoordinator: MainCoordinator? { get }
    func finish()
}

final class ButtonCoordinator: ButtonCoordinatorProtocol {
    var parentCoordinator: MainCoordinator?
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = ButtonViewController.create(ButtonViewModel(), self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func finish() {
        parentCoordinator?.finishChild(self)
    }
    
    deinit {
        print("ButtonCoordinator Deinit")
    }
}
