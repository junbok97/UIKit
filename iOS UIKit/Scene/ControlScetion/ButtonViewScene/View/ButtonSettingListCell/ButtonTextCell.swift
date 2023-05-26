//
//  ButtonTextCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/16.
//

import UIKit
import RxSwift

final class ButtonTextCell: DefaultTextFieldCell, ButtonSettingListCellProtocol {
    
    static override var cellId: String {
        ButtonTextCellConstants.cellId
    }
    
    private var titleType: ButtonTitleType = .title
    
    func setup(_ item: ButtonSettingListItemType) {
        guard case let .text(titleType: titleType) = item else { return }
        self.titleType = titleType
    }
    
    func bind(_ viewModel: ButtonViewModel) {
        textField.rx.text
            .compactMap { [weak self] text -> ButtonText? in
                guard let self = self, let text = text else { return nil }
                return text == "" ? nil : ButtonText(titleType: self.titleType, text: text)
            }
            .bind(onNext: { [weak viewModel] text in
                viewModel?.textDidChanged(text)
            })
            .disposed(by: disposeBag)
    }
}
