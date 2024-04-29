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

    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.register(CodeTableViewCell.self)
        tableView.dataSource = self
        
        tableView.pin.all()
   
    }


}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(CodeTableViewCell.self, for: indexPath)
        return cell
    }
    
    
}

