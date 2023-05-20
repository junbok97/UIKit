//
//  ChildCoordinatorFactory.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/13.
//

import UIKit

final class ChildCoordinatorFactory {
    
    let parentCoordinator: CoordinatorProtocol
    let navigationController: UINavigationController
    
    init(
        _ parentCoordinator: CoordinatorProtocol,
        _ navigationController: UINavigationController
    ) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func makeCoordinator(type: ObjectType) -> CoordinatorProtocol {
        switch type {
        case .label:
            let coordinator =  LabelCoordinator(navigationController, self.parentCoordinator)
            return coordinator
        case .button:
            let coordinator = ButtonCoordinator(navigationController, self.parentCoordinator)
            return coordinator
        case .sfSymbols:
            let coordinator = SFSymbolsCoordinator(navigationController, self.parentCoordinator)
            return coordinator
        default:
            let coordinator =  LabelCoordinator(navigationController, self.parentCoordinator)
            return coordinator
        }
    }
}
