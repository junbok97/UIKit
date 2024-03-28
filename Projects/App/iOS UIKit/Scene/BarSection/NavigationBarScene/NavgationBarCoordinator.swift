//
//  NavgationBarCoordinator.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/20.
//

import UIKit

protocol NavgationBarCoordinatorProtocol: CoordinatorProtocol {
    
}
 
final class NavgationBarCoordinator: NavgationBarCoordinatorProtocol {
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
        
    }
    
}
