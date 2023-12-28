//
//  UICollectionReusableViewProtocol.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/07/03.
//

import UIKit

protocol UICollectionReusableViewProtocol {
    static var viewId: String { get }
    static var isFromNib: Bool { get }
    
    static func register(collectionView: UICollectionView, kind: String)
    static func dequeueReusableSupplementaryView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> Self
}

extension UICollectionReusableViewProtocol where Self: UICollectionReusableView {
    
    static func register(collectionView: UICollectionView, kind: String) {
        if self.isFromNib {
            collectionView.register(UINib(nibName: self.viewId, bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: self.viewId)
        } else {
            collectionView.register(Self.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: self.viewId)
            
        }
    }
    
    static func dequeueReusableSupplementaryView(collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> Self {
        guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.viewId, for: indexPath) as? Self else {
            fatalError("Error \(self.viewId)")
        }
        return supplementaryView
    }
    
}
