//
//  SwitchCoordinator.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import UIKit

protocol SwitchCoordinatorProtocol: CoordinatorProtocol {}

final class SwitchCoordinator: SwitchCoordinatorProtocol {
    var navigationController: UINavigationController
    
    var childCoordinators: [CoordinatorProtocol] = []
    
    var parentCoordinator: CoordinatorProtocol?
    
    init(
        _ navigationController: UINavigationController,
        _ parentCoordinator: CoordinatorProtocol?
    ) {
        self.navigationController = navigationController
        self.parentCoordinator = parentCoordinator
    }
    
    func start() {
        let viewContrller = SwitchViewController.create(self, SwitchViewModel())
        navigationController.pushViewController(viewContrller, animated: true)
    }
    
}
