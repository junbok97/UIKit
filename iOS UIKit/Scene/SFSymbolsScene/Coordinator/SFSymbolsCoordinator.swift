//
//  SFSymbolsCoordinator.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import UIKit

protocol SFSymbolsCoordinatorProtocol: CoordinatorProtocol {
    var parentCoordinator: MainCoordinator? { get }
    func finish()
}

final class SFSymbolsCoordinator: SFSymbolsCoordinatorProtocol {
    var parentCoordinator: MainCoordinator?
    var navigationController: UINavigationController
    var childCoordinators: [CoordinatorProtocol] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SFSymbolsViewModel()
        let viewController = SFSymbolsViewController.create(viewModel, self)
        navigationController.pushViewController(viewController, animated: true)
    }

    func finish() {
        parentCoordinator?.finishChild(self)
    }
    
    deinit {
        print("SFSymbolsCoordinator Deinit")
    }
}
