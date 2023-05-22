//
//  SwitchViewControllerConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import Foundation

protocol SwitchViewControllerConstantsProtocol: DefaultListViewControllerConstantsProtocol {}

extension SwitchViewControllerConstantsProtocol {
    static var title: String { "Switch" }
    static var containerViewHeight: CGFloat { 50.0 }
}

struct SwitchViewControllerConstants: SwitchViewControllerConstantsProtocol {
}
