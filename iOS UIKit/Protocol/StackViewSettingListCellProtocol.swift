//
//  StackSettingListCellProtocol.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import Foundation

protocol StackViewSettingListCellProtocol {
    func setup(_ item: StackViewSettingListItemType)
    func bind(_ viewModel: StackViewViewModel)
}
