//
//  LabelColorCell.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/04/11.
//

import UIKit
import RxSwift
import RxCocoa

final class LabelColorCell: DefaultColorCell, LabelSettingListCellProtocol {
    
    static override var cellId: String { LabelColorCellConstants.cellId }

    private var colorTypeStream: Observable<LabelColorType> = Observable.just(.titleColor)
    
    func setup(_ item: LabelSettingListItemType) {
        guard case let .color(type: type) = item else { return }
        self.colorTypeStream = Observable.just(type)
        Observable.just(type.rawValue)
            .bind(to: self.rx.colorNameLabelText)
            .disposed(by: disposeBag)
    }
    
    func bind(_ viewModel: LabelViewModelProtocol) {
        selectedColorSubject
            .withLatestFrom(colorTypeStream) { color, colorType in
                LabelColor(colorType: colorType, color: color)
            }
            .distinctUntilChanged()
            .bind(onNext: { [weak viewModel] labelColor in
                viewModel?.colorCellDidSelected(labelColor)
            })
            .disposed(by: disposeBag)
    }
    
}
