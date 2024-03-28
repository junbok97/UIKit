//
//  SwitchSettingListCellProtocol.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import Foundation

protocol SwitchSettingListCellProtocol {
    func setup(_ item: SwitchSettingListItemType)
    func bind(_ viewModel: SwitchViewModelProtocol)
}
