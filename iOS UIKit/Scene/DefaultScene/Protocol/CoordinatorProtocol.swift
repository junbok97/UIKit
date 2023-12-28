//
//  CoordinatorProtocol.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get }
    var parentCoordinator: CoordinatorProtocol? { get }
    
    var childCoordinators: [CoordinatorProtocol] { get set }

    func start()

    init(
        _ navigationController: UINavigationController,
        _ parentCoordinator: CoordinatorProtocol?
    )
}

extension CoordinatorProtocol {
    func finish() {
        parentCoordinator?.finishChild(self)
    }
    
    func finishChild(_ child: CoordinatorProtocol) {
        childCoordinators = childCoordinators.filter { $0 !== child }
        navigationController.popViewController(animated: true)
    }
}
