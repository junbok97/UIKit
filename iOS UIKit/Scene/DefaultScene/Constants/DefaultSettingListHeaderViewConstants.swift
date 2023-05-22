//
//  DefaultSettingListHeaderViewConstants.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/15.
//

import UIKit

protocol DefaultSettingListHeaderViewConstantsProtocol {
    static var viewId: String { get }
    
    static var defaultHorizionOffset: CGFloat { get }
    static var defaultVerticalOffset: CGFloat { get }
    static var defaultFont: UIFont { get }
}

extension DefaultSettingListHeaderViewConstantsProtocol {
    static var viewId: String { "DefaultSettingListHeaderView" }
    
    static var defaultHorizionOffset: CGFloat { 24.0 }
    static var defaultVerticalOffset: CGFloat { 8.0 }
    static var defaultFont: UIFont { .boldSystemFont(ofSize: 20) }
}

struct DefaultSettingListHeaderViewConstants: DefaultSettingListHeaderViewConstantsProtocol {}
