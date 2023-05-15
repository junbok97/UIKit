//
//  ButtonTitleFontSizeCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import Foundation

final class ButtonFontSizeCell: DefaultFontSizeCell, ButtonSettingListCellProtocol {
    static override var cellId: String {
        ButtonFontSizeCellConstants.cellId
    }
    
    private var titleType: ButtonTitleType = .title
    
    func setup(_ item: ButtonSettingListItemType) { }
    func bind(_ viewModel: ButtonViewModel) { }
}
