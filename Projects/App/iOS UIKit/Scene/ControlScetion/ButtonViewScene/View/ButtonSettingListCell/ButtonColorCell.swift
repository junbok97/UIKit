//
//  ButtonColorCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import Foundation
import RxSwift

final class ButtonColorCell: DefaultColorCell, ButtonSettingListCellProtocol {
    static override var cellId: String {
        ButtonColorCellConstants.cellId
    }
    
    private var colorTypeStream: Observable<ButtonColorType> = Observable.just(.titleColor)
    
    func setup(_ item: ButtonSettingListItemType) {
        guard case let .color(type: type) = item else { return }
        self.colorTypeStream = Observable.just(type)
        Observable.just(type.rawValue)
            .bind(to: self.rx.colorNameLabelText)
            .disposed(by: disposeBag)
    }
    
    func bind(_ viewModel: ButtonViewModelProtocol) {
        selectedColorSubject
            .withLatestFrom(colorTypeStream) { color, colorType in
                ButtonColor(colorType: colorType, color: color)
            }
            .distinctUntilChanged()
            .bind(onNext: { [weak viewModel] color in
                viewModel?.colorCellDidSelected(color)
            })
            .disposed(by: disposeBag)
    }
}
