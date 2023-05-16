//
//  LabelFontSizeCell.swift
//  UIKit Test
//
//  Created by 이준복 on 2023/05/08.
//

import UIKit
import RxSwift
import RxCocoa

final class LabelFontSizeCell: DefaultFontSizeCell, LabelSettingListCellProtocol {
    
    static override var cellId: String { LabelFontSizeCellConstants.cellId
    }
    
    func setup(_ item: LabelSettingListItemType) { }
    
    func bind(_ viewModel: LabelViewModel) {
        fontSizeSlider.rx.value
            .startWith(LabelViewControllerConstants.targetLabelFontSize)
            .map { Int($0) }
            .distinctUntilChanged()
            .bind(to: viewModel.fontSizeCellDidChangedFontSizeSlider)
            .disposed(by: disposeBag)
    }
    
}
