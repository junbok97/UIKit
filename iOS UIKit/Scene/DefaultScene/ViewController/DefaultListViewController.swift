//
//  DefaultViewController.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import Foundation
import RxSwift
import RxDataSources

class DefaultListViewController: DefaultViewController {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var settingList: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .secondarySystemBackground
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        attribute()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    override func attribute() {
        super.attribute()
        navigationItem.largeTitleDisplayMode = .never
        settingListConfigure()
        settingListEndEditing()
    }
    
    func layout() {
        [containerView, settingList].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: DefaultListViewControllerConstants.containerViewHeight),
            
            settingList.topAnchor.constraint(equalTo: containerView.bottomAnchor),
            settingList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func settingListConfigure() {
        DefaultCell.register(tableView: settingList)
        DefaultCodeCell.register(tableView: settingList)
        DefaultTextFieldCell.register(tableView: settingList)
        DefaultColorCell.register(tableView: settingList)
        DefaultFontCell.register(tableView: settingList)
        DefaultFontSizeCell.register(tableView: settingList)
        DefaultLabelCell.register(tableView: settingList)
        DefaultSwitchCell.register(tableView: settingList)
        DefaultReloadCodeButtonCell.register(tableView: settingList)
        DefaultTextFieldCell.register(tableView: settingList)
        DefaultSettingListHeaderView.register(tableView: settingList)
    }
    
}

private extension DefaultListViewController {
    func settingListEndEditing() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        settingList.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        settingList.endEditing(true)
    }
}
