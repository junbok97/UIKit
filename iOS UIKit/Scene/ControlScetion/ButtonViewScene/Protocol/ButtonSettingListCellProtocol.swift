//
//  ButtonSettingListCellProtocol.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/15.
//

import Foundation

protocol ButtonSettingListCellProtocol {
    func setup(_ item: ButtonSettingListItemType)
    func bind(_ viewModel: ButtonViewModelProtocol)
}
