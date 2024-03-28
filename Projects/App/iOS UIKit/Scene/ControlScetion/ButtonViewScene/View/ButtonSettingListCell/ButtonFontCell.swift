//
//  ButtonTitleFontCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import Foundation

final class ButtonFontCell: DefaultFontCell, ButtonSettingListCellProtocol {
    
    static override var cellId: String {
        ButtonFontCellConstants.cellId
    }
    
    private var titleType: ButtonTitleType = .title
    
    func setup(_ item: ButtonSettingListItemType) {
        guard case let .font(titleType: titleType, fontType: fontType) = item else { return }
        self.fontType = fontType
        self.titleType = titleType
    }
    
    func bind(_ viewModel: ButtonViewModelProtocol) {}
}
