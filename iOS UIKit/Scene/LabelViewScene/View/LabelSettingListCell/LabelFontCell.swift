//
//  LabelFontCell.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit
import RxSwift
import RxCocoa

final class LabelFontCell: DefaultFontCell, LabelSettingListCellProtocol {
    
    static override var cellId: String { LabelFontCellConstants.cellId }
    
    func setup(_ item: LabelSettingListSectionItemType) {
        guard case let .fontSectionItem(fontType: fontType) = item else { return }
        self.fontType = fontType
    }
    
    func bind(_ viewModel: LabelViewModel) { }
    
}
