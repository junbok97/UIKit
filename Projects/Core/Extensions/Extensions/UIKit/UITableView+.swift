//
//  UITableView+.swift
//  Extensions
//
//  Created by 이준복 on 3/25/24.
//

import UIKit

public extension UITableViewCell {
    static var id: String {
        String(describing: self)
    }
}

public extension UITableViewHeaderFooterView {
    static var id: String {
        String(describing: self)
    }
}

public extension UITableView {
    
    func register<T: UITableViewCell>(_ cell: T.Type) {
        register(cell, forCellReuseIdentifier: cell.id)
    }
    
    func dequeue<T: UITableViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: cell.id, for: indexPath) as? T else {
            return .init()
        }
        return cell
    }
    
    func register<T: UITableViewHeaderFooterView>(_ view: T.Type) {
        register(view, forHeaderFooterViewReuseIdentifier: view.id)
    }
    
    func dequeue<T: UITableViewHeaderFooterView>(_ view: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: view.id) as? T else {
            return .init()
        }
        return view
    }
        
}



