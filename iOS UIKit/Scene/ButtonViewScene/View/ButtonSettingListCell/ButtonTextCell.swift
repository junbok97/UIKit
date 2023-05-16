//
//  ButtonTextCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/16.
//

import UIKit
import RxSwift

final class ButtonTextCell: DefaultTextCell, ButtonSettingListCellProtocol {
    
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
            .compactMap { $0 == "" ? nil : $0 }
            .map {
                ButtonText(titleType: self.titleType, text: $0)
            }
            .bind(to: viewModel.buttonConfigurationModel.textDidChangedTextField)
            .disposed(by: disposeBag)
    }
}
