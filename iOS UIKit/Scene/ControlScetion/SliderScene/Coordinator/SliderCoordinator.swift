//
//  SliderCoordinator.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import UIKit

protocol SliderCoordinatorProtocol: CoordinatorProtocol {}

final class SliderCoordinator: SliderCoordinatorProtocol {
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
        let viewController = SliderViewController.create(SliderViewModel(), self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    deinit {
        print("StepperCoordinator Deinit")
    }

}
