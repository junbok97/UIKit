//
//  StepperCodeCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import UIKit
import RxSwift

final class StepperCodeCell: DefaultCodeCell, StepperSettingListCellProtocol {
    override class var cellId: String {
        StepperCodeCellConstants.cellId
    }
    
    func setup(_ item: StepperSettingListItemType) {}
    
    func bind(_ viewModel: StepperViewModel) {
        viewModel.codeCellCodeLabelText
            .drive(self.rx.codeText)
            .disposed(by: disposeBag)
    }
}
