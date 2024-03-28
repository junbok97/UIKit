//
//  UIStackView+.swift
//  Extensions
//
//  Created by 이준복 on 3/25/24.
//

import UIKit

public extension UIStackView {
    func addArrangedSubviews(_ views: UIView ...) {
        views.forEach { addArrangedSubview($0) }
    }
}
