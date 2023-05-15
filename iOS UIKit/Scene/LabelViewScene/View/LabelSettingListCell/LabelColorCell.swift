//
//  LabelColorCell.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit
import RxSwift
import RxCocoa

final class LabelColorCell: DefaultColorCell, LabelSettingListCellProtocol {
    
    static override var cellId: String { LabelColorCellConstants.cellId }
    
    func setup(_ item: LabelSettingListItemType) {
        guard case let .color(colorType: colorType) = item else { return }
        self.colorType = colorType
    }
    
    func bind(_ viewModel: LabelViewModel) {
        selectedColorSubject
            .map { color in
                ObjectColor(colorType: self.colorType, color: color)
            }
            .bind(to: viewModel.colorCellDidSelected)
            .disposed(by: disposeBag)
    }
    
}
