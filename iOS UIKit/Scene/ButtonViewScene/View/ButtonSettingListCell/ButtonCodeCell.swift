//
//  ButtonCodeCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit
import RxSwift

final class ButtonCodeCell: DefaultCodeCell, ButtonSettingListCellProtocol {
    
    static override var cellId: String {
        ButtonCodeCellConstants.cellId
    }
    
    func setup(_ item: ButtonSettingListItemType) { }
    func bind(_ viewModel: ButtonViewModel) {
        viewModel.codeCellCodeLabelText
            .drive(self.rx.codeText)
            .disposed(by: disposeBag)
    }

}
