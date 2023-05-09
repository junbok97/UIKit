//
//  UICollectionViewCellRegister.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import UIKit

protocol UICollectionViewCellRegister {
    
    // cellId
    static var cellId: String { get }
    // xib파일로 CustomCell을 만들었는지 유무
    static var isFromNib: Bool { get }
    
    // CustomCell 등록
    static func register(target: UICollectionView)
    // CustomCell 꺼내오기
    static func dequeueReusableCell(target: UICollectionView, indexPath: IndexPath) -> Self
}


extension UICollectionViewCellRegister where Self: UICollectionViewCell {
    
    // CollectionView에 CustomCell 등록
    static func register(target: UICollectionView) {
        // xib파일로 생성한 Cell이라면
        if self.isFromNib { target.register(UINib(nibName: self.cellId, bundle: nil), forCellWithReuseIdentifier: cellId) }
        // 코드로만 생성한 Cell이라면
        else { target.register(Self.self, forCellWithReuseIdentifier: self.cellId) }
    }
    
    // CustomCell 꺼내오기
    static func dequeueReusableCell(target: UICollectionView, indexPath: IndexPath) -> Self {
        guard let cell = target.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as? Self else { fatalError("Error! \(self.cellId)") }
        return cell
    }
}
