//
//  SwitchCodeCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import Foundation
import RxSwift

final class SwitchCodeCell: DefaultCodeCell, SwitchSettingListCellProtocol {
    static override var cellId: String {
        SwitchCodeCellConstants.cellId
    }
    
    func setup(_ item: SwitchSettingListItemType) {}
    func bind(_ viewModel: SwitchViewModel) {
        viewModel.codeCellCodeLabelText
            .drive(self.rx.codeText)
            .disposed(by: disposeBag)
    }
}
