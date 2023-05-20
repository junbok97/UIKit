//
//  SceneDelegate.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/03/15.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    var mainCoordinator: MainCoordinatorProtocol?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        
        let navigationController = UINavigationController()
        self.mainCoordinator = MainCoordinator(navigationController, nil)
        self.mainCoordinator?.start()
        
        self.window?.backgroundColor = .systemBackground
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
    }
    
}
