//
//  StackViewTextFieldCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import Foundation
import RxSwift

final class StackViewSpacingCell: DefaultTextFieldCell, StackViewSettingListCellProtocol {
    override class var cellId: String {
        StackViewSpacingCellConstants.cellId
    }
    
    private var valueTypeStream: Observable<CGFloat> = Observable.just(10.0)
    
    func setup(_ item: StackViewSettingListItemType) {
        textField.keyboardType = .decimalPad
    }
    
    func bind(_ viewModel: StackViewViewModel) {
        textField.rx.text
            .compactMap { CGFloat($0 ?? "") }
            .distinctUntilChanged()
            .bind(onNext: { [weak viewModel] value in
                viewModel?.valueCellDidChanged(value)
            })
            .disposed(by: disposeBag)
    }
}
