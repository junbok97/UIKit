//
//  StepperSettingListCellProtocol.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/23.
//

import Foundation

protocol StepperSettingListCellProtocol {
    func setup(_ item: StepperSettingListItemType)
    func bind(_ viewModel: StepperViewModelProtocol)
}
