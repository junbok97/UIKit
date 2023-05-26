//
//  SliderSettingListCellProtocol.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/26.
//

import Foundation

protocol SliderSettingListCellProtocol {
    func setup(_ item: SliderSettingListItemType)
    func bind(_ viewModel: SliderViewModel)
}
