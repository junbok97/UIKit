//
//  ButtonFontSizeCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/16.
//

import Foundation
import RxSwift

final class ButtonFontSizeCell: DefaultFontSizeCell, ButtonSettingListCellProtocol {
    static override var cellId: String {
        ButtonFontSizeCellConstants.cellId
    }
    
    private var titleType: ButtonTitleType = .title
    
    func setup(_ item: ButtonSettingListItemType) {
        guard case let .fontSize(titleType: titleType) = item else { return }
        self.titleType = titleType
    }
    
    func bind(_ viewModel: ButtonViewModel) {
        fontSizeSlider.rx.value
            .map { Int($0) }
            .distinctUntilChanged()
            .map {
                ButtonFontSize(titleType: self.titleType, fontSize: $0)
            }
            .bind(to: viewModel.fontSizeDidChangedFontSizeSlider)
            .disposed(by: disposeBag)
      
    }
}

