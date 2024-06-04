//
//  ViewController.swift
//  DesignKitDemoApp
//
//  Created by 이준복 on 3/28/24.
//

import UIKit

import PinLayout

import DesignKit
import Extensions

final class ViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.register(DKLabelTableViewCell.self)
        tableView.register(DKInputTableViewCell.self)
        tableView.register(DKColorTableViewCell.self)
        tableView.register(DKStepperTableViewCell.self)
        tableView.register(DKCodeTableViewCell.self)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        
        navigationController?.navigationBar.tintColor = .label
        navigationItem.backButtonTitle = ""
       
        tableView.pin.all()
    }
 
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 30
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            return tableView.dequeue(DKStepperTableViewCell.self, for: indexPath)
        } else if indexPath.section == 1 {
            return tableView.dequeue(DKCodeTableViewCell.self, for: indexPath)
        } else {
            return tableView.dequeue(DKLabelTableViewCell.self, for: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            navigationController?.pushViewController(DKListViewController(), animated: true)
        }
    }
    
    
}

