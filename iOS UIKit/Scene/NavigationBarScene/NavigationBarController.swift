//
//  NavigationBarController.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/20.
//

import UIKit

final class NavigationBarContrller: DefaultViewController {
    
    private lazy var settingList: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    private lazy var popViewControllerButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("test", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
}
