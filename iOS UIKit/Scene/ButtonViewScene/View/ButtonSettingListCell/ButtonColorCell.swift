//
//  ButtonColorCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import Foundation

final class ButtonColorCell: DefaultColorCell, ButtonSettingListCellProtocol {
    static override var cellId: String {
        ButtonColorCellConstants.cellId
    }
    
    func setup(_ item: ButtonSettingListItemType) {
        guard case let .color(colorType: colorType) = item else { return }
        self.colorType = colorType
    }
    
    func bind(_ viewModel: ButtonViewModel) {
        selectedColorSubject
            .distinctUntilChanged()
            .bind(onNext: viewModel.colorCellDidSelected)
            .disposed(by: disposeBag)
    }
}
