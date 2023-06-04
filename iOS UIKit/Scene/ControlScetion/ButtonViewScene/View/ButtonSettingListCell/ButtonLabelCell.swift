//
//  ButtonLabelCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/15.
//

import Foundation

final class ButtonLabelCell: DefaultLabelCell, ButtonSettingListCellProtocol {
    static override var cellId: String {
        ButtonLabelCellConstants.cellId
    }
    
    func setup(_ item: ButtonSettingListItemType) {
        switch item {
        case let .buttonStyle(type: type):
            setupLabelText(type.rawValue)
        case let .corner(type: type):
            setupLabelText(type.rawValue)
        case let .buttonTitleAlignment(type: type):
            setupLabelText(type.rawValue)
        case let .imagePlacement(type: type):
            setupLabelText(type.rawValue)
        default:
            return
        }
    }
    
    func bind(_ viewModel: ButtonViewModelProtocol) { }
}
