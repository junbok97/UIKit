//
//  ObjectListCellConstants.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/05/06.
//

import UIKit

protocol ObjectListCellConstantsProtocol: DefaultCellConstantsProtocol {
    
    static var imageViewHeight: CGFloat { get }
    static var imageViewWidth: CGFloat { get }
    static var imageViewLayerCornerRadius: CGFloat { get }
    
    static var titleFont: UIFont { get }
}

extension ObjectListCellConstantsProtocol {
    static var cellId: String { "ObjectListCell" }
    
    static var imageViewHeight: CGFloat { 90.0 }
    static var imageViewWidth: CGFloat { 120.0 }
    static var imageViewLayerCornerRadius: CGFloat { 12.0 }
    
    static var titleFont: UIFont { .systemFont(ofSize: 20, weight: .medium) }
}

struct ObjectListCellConstants: ObjectListCellConstantsProtocol { }
