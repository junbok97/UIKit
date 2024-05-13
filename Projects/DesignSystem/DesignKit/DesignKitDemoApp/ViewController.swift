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
                            DKInputTableViewCellListener,
                            ColorTableViewCellListener {
    
    
    private let inputTextSubject: PublishSubject<String> = .init()
    private let selectColorSubject: PublishSubject<UIColor> = .init()
    
    private var disposBag = DisposeBag()
    
    
    var inputText: AnyObserver<String> { inputTextSubject.asObserver() }
    var selectColor: AnyObserver<UIColor> { selectColorSubject.asObserver() }
    
    
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        tableView.register(DKLabelTableViewCell.self)
        tableView.register(DKInputTableViewCell.self)
        tableView.register(ColorTableViewCell.self)
        tableView.dataSource = self
        
        tableView.pin.all()
        
        inputTextSubject.subscribe {
            print($0)
        }.disposed(by: disposBag)
        
        selectColorSubject.subscribe {
            print($0)
        }.disposed(by: disposBag)
   
    }


}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(ColorTableViewCell.self, for: indexPath)
        cell.bind(self)
        return cell
    }
    
    
}

