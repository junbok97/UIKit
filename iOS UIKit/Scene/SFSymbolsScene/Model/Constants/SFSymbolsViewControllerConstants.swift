//
//  SFSymbolsViewControllerConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/09.
//

import UIKit

protocol SFSymbolsViewControllerConstantsProtocol: DefaultViewControllerConstantsProtocol {
    static var itemSizeWidth: NSCollectionLayoutDimension { get }
    static var itemSizeHeight: NSCollectionLayoutDimension { get }
    
    static var groupSizeWidth: NSCollectionLayoutDimension { get }
    static var groupSizeHeight: NSCollectionLayoutDimension { get }
    
    static var groupItemCount: Int { get }
}

extension SFSymbolsViewControllerConstantsProtocol {
    static var title: String { "SF Symbols" }
    static var documentURLString: String { "https://developer.apple.com/sf-symbols/" }
    
    static var itemSizeWidth: NSCollectionLayoutDimension { .fractionalWidth(0.3) }
    static var itemSizeHeight: NSCollectionLayoutDimension { .fractionalHeight(1) }
    
    static var groupSizeWidth: NSCollectionLayoutDimension { .fractionalWidth(1) }
    static var groupSizeHeight: NSCollectionLayoutDimension { .fractionalWidth(0.5) }
    
    static var groupItemCount: Int { 3 }
}

struct SFSymbolsViewControllerConstants: SFSymbolsViewControllerConstantsProtocol {}
