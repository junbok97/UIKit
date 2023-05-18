//
//  ButtonCoordinator.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit

protocol ButtonCoordinatorProtocol: CoordinatorProtocol {
    func showSFSymbolsScene()
}

final class ButtonCoordinator: ButtonCoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol?
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []

    private let viewModel = ButtonViewModel()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = ButtonViewController.create(viewModel, self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showSFSymbolsScene() {
        let child = SFSymbolsCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start(viewModel)
    }
    
    deinit {
        print("ButtonCoordinator Deinit")
    }
}
