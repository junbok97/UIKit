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
        case let .buttonType(buttonType: buttonType):
            setupLabelText(buttonType.rawValue)
        case let .buttonStyle(buttonStyle: buttonStyle):
            setupLabelText(buttonStyle.rawValue)
        case let .corner(cornerStyleType: cornerStyleType):
            setupLabelText(cornerStyleType.rawValue)
        default:
            return
        }
    }
    
    func bind(_ viewModel: ButtonViewModel) { }
}
