//
//  SFSymbolsCoordinator.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import UIKit

protocol SFSymbolsCoordinatorProtocol: CoordinatorProtocol {
    
}

final class SFSymbolsCoordinator: SFSymbolsCoordinatorProtocol {
    var parentCoordinator: CoordinatorProtocol?
    var childCoordinators: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    private let viewModel: SFSymbolsViewModel = SFSymbolsViewModel()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SFSymbolsViewController.create(viewModel, self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func start(_ buttonViewModel: ButtonViewModel) {
        let viewController = SFSymbolsViewController.create(viewModel, self)
        viewController.bind(buttonViewModel)
        navigationController.pushViewController(viewController, animated: true)
    }

    deinit {
        print("SFSymbolsCoordinator Deinit")
    }
}
