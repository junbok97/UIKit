//
//  UICollectionView+.swift
//  Extensions
//
//  Created by 이준복 on 3/25/24.
//

import UIKit

public extension UICollectionReusableView {
    static var id: String {
        String(describing: self)
    }
}

public extension UICollectionView {
    
    func register<T: UICollectionViewCell>(_ cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: cell.id)
    }
    
    
    func dequeue<T: UICollectionViewCell>(_ cell: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: cell.id,
            for: indexPath
        ) as? T else {
            return .init()
        }
        return cell
    }
    
    
    func register<T: UICollectionReusableView>(_ view: T.Type, forSupplementaryViewOfKind: String) {
        register(view, forSupplementaryViewOfKind: forSupplementaryViewOfKind, withReuseIdentifier: view.id)
    }
    
    
    func dequeue<T: UICollectionReusableView>(_ view: T.Type, ofKind: String, for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(
            ofKind: ofKind,
            withReuseIdentifier: view.id,
            for: indexPath
        ) as? T else {
            return .init()
        }
        return view
    }
     
}


