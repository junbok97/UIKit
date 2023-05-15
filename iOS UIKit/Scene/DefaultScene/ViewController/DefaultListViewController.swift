//
//  DefaultViewController.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import Foundation
import RxSwift
import RxDataSources

class DefaultListViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    private lazy var leftBarButtonItem: UIBarButtonItem = {
        let barbutton =  UIBarButtonItem(
            image: DefaultViewControllerConstants.leftBarButtontImage,
            style: .plain,
            target: self,
            action: #selector(didTappedLeftBarButton)
        )
        barbutton.tintColor = .label
        return barbutton
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var settingList: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    @objc func didTappedLeftBarButton() { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = leftBarButtonItem
        attribute()
        layout()
    }
    
    func bind() {}
    
    func attribute() {
        view.backgroundColor = .secondarySystemBackground
        navigationController?.navigationBar.standardAppearance = UINavigationBarAppearance()
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func layout() {
        [containerView, settingList].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: DefaultViewControllerConstants.containerViewHeight),
            
            settingList.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            settingList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
