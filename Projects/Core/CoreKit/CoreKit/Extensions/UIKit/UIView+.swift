//
//  UIView+.swift
//  Extensions
//
//  Created by 이준복 on 3/25/24.
//

import UIKit

public extension UIView {
    
    func addSubviews(_ views: UIView ...) {
        views.forEach { addSubview($0) }
    }
    
}
