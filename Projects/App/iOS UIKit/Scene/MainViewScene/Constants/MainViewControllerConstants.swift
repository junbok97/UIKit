//
//  MainViewControllerConstants.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit

protocol MainViewControllerConstantsProtocol: DefaultViewControllerConstantsProtocol {
}

extension MainViewControllerConstantsProtocol {
    static var title: String { "Objects" }

    static var defaultFont: UIFont { .systemFont(ofSize: 20) }
}

struct MainViewControllerConstants: MainViewControllerConstantsProtocol {}
