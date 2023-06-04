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
    
    private var valueTypeStream: Observable<CGFloat> = Observable.just(StackViewControllerConstants.targetSpacing)
    
    func setup(_ item: StackViewSettingListItemType) {
        textField.keyboardType = .decimalPad
        textField.placeholder = StackViewSpacingCellConstants.placeHolder
    }
    
    func bind(_ viewModel: StackViewViewModel) {
        textField.rx.text
            .compactMap { Double($0 ?? "") }
            .map { CGFloat($0) }
            .distinctUntilChanged()
            .bind(onNext: { [weak viewModel] spacing in
                viewModel?.setTargetSpacing(spacing)
            })
            .disposed(by: disposeBag)
    }
}
