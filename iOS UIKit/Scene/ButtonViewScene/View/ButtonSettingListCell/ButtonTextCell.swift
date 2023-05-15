//
//  ButtonTitleCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit
import RxSwift

final class ButtonTextCell: DefaultTextCell, ButtonSettingListCellProtocol {
    
    static override var cellId: String {
        ButtonTextCellConstants.cellId
    }
    
    private var titleType: ButtonTitleType = .title
    
    func setup(_ item: ButtonSettingListItemType) { }
    
    func bind(_ viewModel: ButtonViewModel) { }
}
