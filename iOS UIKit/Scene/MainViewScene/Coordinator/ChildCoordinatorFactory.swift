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
        case .uiLabel:
            return LabelCoordinator(navigationController, self.parentCoordinator)
        case .uiButton:
            return ButtonCoordinator(navigationController, self.parentCoordinator)
        case .uiSwitch:
            return SwitchCoordinator(navigationController, self.parentCoordinator)
        case .sfSymbols:
            return SFSymbolsCoordinator(navigationController, self.parentCoordinator)
        default:
            return LabelCoordinator(navigationController, self.parentCoordinator)
        }
    }
}
