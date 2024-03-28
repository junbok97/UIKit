//
//  LabelAlignmentCell.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/13.
//

import UIKit
import RxSwift
import RxCocoa

final class LabelAlignmentCell: DefaultLabelCell, LabelSettingListCellProtocol {
    
    static override var cellId: String { LabelAlignmentCellConstants.cellId }
    
    
    func setup(_ item: LabelSettingListItemType) {
        guard case let .alignment(type) = item else {
            return
        }
        setupLabelText(type.rawValue)
        setupLabelTextAlignment(type.aligment)
    }
    
    func bind(_ viewModel: LabelViewModelProtocol) { }
    

}
