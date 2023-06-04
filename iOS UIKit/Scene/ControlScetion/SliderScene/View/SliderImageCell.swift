//
//  SliderImageCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import Foundation

final class SliderImageCell: DefaultLabelCell, SliderSettingListCellProtocol {
    override class var cellId: String {
        SliderImageCellConstants.cellId
    }
    
    func setup(_ item: SliderSettingListItemType) {
        
    }
    
    func bind(_ viewModel: SliderViewModelProtocol) {
        
    }
}
