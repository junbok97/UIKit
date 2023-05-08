//
//  ChildCoordinatorFactory.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/13.
//

import UIKit

final class ChildCoordinatorFactory {
    
    let parentCoordinator: MainCoordinator
    let navigationController: UINavigationController
    
    init(parentCoordinator: MainCoordinator, navigationController: UINavigationController) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func makeCoordinator(type: ObjectType) -> CoordinatorProtocol {
        switch type {
        case .label:
            let labelCoordinator =  LabelCoordinator(navigationController: navigationController)
            labelCoordinator.parentCoordinator = self.parentCoordinator
            return labelCoordinator
        default:
            let labelCoordinator =  LabelCoordinator(navigationController: navigationController)
            labelCoordinator.parentCoordinator = self.parentCoordinator
            return labelCoordinator
        }
    }
}
