//
//  LabelSettingListCellProtocol.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import Foundation

protocol LabelSettingListCellProtocol {
    func setup(_ item: LabelSettingListSectionItemType)
    func bind(_ viewModel: LabelViewModel)
}
