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
    
    override func attribute() {
        super.attribute()
        fontSizeSlider.setValue(ButtonFontSizeCellConstants.sliderValue, animated: true)
        fontSizeSlider.maximumValue = ButtonFontSizeCellConstants.sliderMaximimValue
        sliderValueLabel.text = ButtonFontSizeCellConstants.sliderValueLabelText
        maxNumLabel.text = ButtonFontSizeCellConstants.maxNumLabelText
    }
    
    func setup(_ item: ButtonSettingListItemType) {
        guard case let .fontSize(titleType: titleType) = item else { return }
        self.titleType = titleType
    }
    
    func bind(_ viewModel: ButtonViewModel) {
        fontSizeSlider.rx.value
            .map { Int($0) }
            .distinctUntilChanged()
            .compactMap { [weak self] value -> ButtonFontSize? in
                guard let self = self else { return nil }
                return ButtonFontSize(titleType: self.titleType, fontSize: value)
            }
            .bind(onNext: { [weak viewModel] fontSize in
                viewModel?.fontSizeDidChanged(fontSize)
            })
            .disposed(by: disposeBag)
    }
}
