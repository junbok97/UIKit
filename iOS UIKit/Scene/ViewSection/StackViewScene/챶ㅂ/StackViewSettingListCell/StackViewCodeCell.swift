//
//  StackViewCodeCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import UIKit
import RxSwift

final class StackViewCodeCell: DefaultCodeCell, StackViewSettingListCellProtocol {
    static override var cellId: String { StackViewCodeCellConstants.cellId }
    
    func setup(_ item: StackViewSettingListItemType) { }

    func bind(_ viewModel: StackViewViewModel) {
        viewModel.codeCellText
            .drive(self.rx.codeText)
            .disposed(by: disposeBag)
    }
}
