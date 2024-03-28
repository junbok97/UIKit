//
//  UITableViewHeaderFooterViewRegister.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/03/15.
//

import UIKit

protocol UITableViewHeaderFooterViewRegister {
    static var viewId: String { get }
    static var isFromNib: Bool { get }
    
    static func register(tableView: UITableView)
    static func dequeueReusableHeaderFooterView(tableView: UITableView) -> Self
}

extension UITableViewHeaderFooterViewRegister where Self: UIView {
    static func register(tableView: UITableView) {
        if self.isFromNib {
            tableView.register(UINib(nibName: self.viewId, bundle: nil), forHeaderFooterViewReuseIdentifier: self.viewId)
        } else {
            tableView.register(Self.self, forHeaderFooterViewReuseIdentifier: self.viewId)
        }
    }
    
    static func dequeueReusableHeaderFooterView(tableView: UITableView) -> Self {
        guard let hfview = tableView.dequeueReusableHeaderFooterView(withIdentifier: self.viewId) as? Self else { fatalError("Error! \(self.viewId)") }
        return hfview
    }
}
