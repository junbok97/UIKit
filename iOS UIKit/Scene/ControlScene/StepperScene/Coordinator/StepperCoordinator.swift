//
//  StepperCoordinator.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/23.
//

import UIKit

protocol StepperCoordinatorProtocol: CoordinatorProtocol {}

final class StepperCoordinator: StepperCoordinatorProtocol {
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
        let viewController = StepperViewController.create(StepperViewModel(), self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    deinit {
        print("StepperCoordinator Deinit")
    }
}
