//
//  CoordinatorProtocol.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }

    func start()
    func finish()
    
    init(navigationController: UINavigationController)
    
}
