//
//  SliderValueCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/26.
//

import Foundation
import RxSwift

final class SliderValueCell: DefaultTextFieldCell, SliderSettingListCellProtocol {
    override class var cellId: String {
        SliderValueCellConstants.cellId
    }
    
    private var valueTypeStream: Observable<SliderValueType> = Observable.just(.maximum)
    
    func setup(_ item: SliderSettingListItemType) {
        guard case let .value(valueType: valueType) = item else { return }
        self.valueTypeStream = Observable.just(valueType)
        textField.placeholder = valueType.rawValue
        textField.keyboardType = .decimalPad
    }
    
    func bind(_ viewModel: SliderViewModelProtocol) {
        textField.rx.text
            .compactMap { Float($0 ?? "") }
            .withLatestFrom(valueTypeStream) { value, valueType in
                SliderValue(valueType: valueType, value: value)
            }
            .distinctUntilChanged()
            .bind(onNext: { [weak viewModel] sliderValue in
                viewModel?.valueCellDidChanged(sliderValue)
            })
            .disposed(by: disposeBag)
    }
}
