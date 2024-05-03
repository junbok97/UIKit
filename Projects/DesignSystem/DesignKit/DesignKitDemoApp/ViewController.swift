//
//  ViewController.swift
//  DesignKitDemoApp
//
//  Created by 이준복 on 3/28/24.
//

import UIKit

import PinLayout
import RxSwift

import DesignKit
import Extensions

final class ViewController: UIViewController,
                            InputTableViewCellListener {
    
    
    private let inputSubject: PublishSubject<String> = .init()
    private var disposBag = DisposeBag()
    
    var inputText: AnyObserver<String> { inputSubject.asObserver() }
    
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.register(CodeTableViewCell.self)
        tableView.register(InputTableViewCell.self)
        tableView.dataSource = self
        
        tableView.pin.all()
        
        inputSubject.subscribe {
            print($0)
        }.disposed(by: disposBag)
   
    }


}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(InputTableViewCell.self, for: indexPath)
        cell.bind(self)
        return cell
    }
    
    
}

