//
//  StackViewLabelCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import UIKit
import RxSwift
import RxCocoa

final class StackViewLabelCell: DefaultLabelCell, StackViewSettingListCellProtocol {
    
    static override var cellId: String {
        StackViewLabelCellConstants.cellId
    }
    
    func setup(_ item: StackViewSettingListItemType) {
        switch item {
        case let .axis(type: type):
            setupLabelText(type.rawValue)
        case let .alignment(type: type):
            setupLabelText(type.rawValue)
        case let .distribution(type: type):
            setupLabelText(type.rawValue)
        default:
            return
        }
    }
    
    func bind(_ viewModel: StackViewViewModelProtocol) { }
}
