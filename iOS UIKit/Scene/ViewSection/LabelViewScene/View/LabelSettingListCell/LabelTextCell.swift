//
//  LabelTextCell.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/12.
//

import UIKit
import RxSwift
import RxCocoa

final class LabelTextCell: DefaultTextFieldCell, LabelSettingListCellProtocol {

    static override var cellId: String { LabelTextCellConstants.cellId }
    
    func setup(_ item: LabelSettingListItemType) {
        textField.placeholder = LabelViewControllerConstants.title
    }
    
    func bind(_ viewModel: LabelViewModelProtocol) {
        textField.rx.text
            .compactMap { $0 == "" ? LabelViewControllerConstants.title : $0 }
            .bind(to: viewModel.textCellDidChangedTextField)
            .disposed(by: disposeBag)
    }
    
}
