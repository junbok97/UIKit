//
//  DefaultListViewControllerConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/20.
//

import Foundation

protocol DefaultListViewControllerConstantsProtocol: DefaultViewControllerConstantsProtocol {
    static var containerViewHeight: CGFloat { get }
}

extension DefaultListViewControllerConstantsProtocol {
    static var title: String { "DefaultList" }
    static var containerViewHeight: CGFloat { 200.0 }
}

struct DefaultListViewControllerConstants: DefaultListViewControllerConstantsProtocol {}
