//
//  SliderCodeCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import Foundation
import RxSwift

final class SliderCodeCell: DefaultCodeCell, SliderSettingListCellProtocol {
    override class var cellId: String {
        SliderCodeCellConstants.cellId
    }
    
    func setup(_ item: SliderSettingListItemType) {}
    
    func bind(_ viewModel: SliderViewModel) {
        viewModel.codeCellCodeLabelText
            .drive(self.rx.codeText)
            .disposed(by: disposeBag)
    }
    
}
