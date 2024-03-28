//
//  SliderColorCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import Foundation
import RxSwift

final class SliderColorCell: DefaultColorCell, SliderSettingListCellProtocol {
    override class var cellId: String {
        SliderColorCellConstatns.cellId
    }
    
    private var colorTypeStream: Observable<SliderColorType> = Observable.just(.tint)
    
    func setup(_ item: SliderSettingListItemType) {
        guard case let .color(colorType: colorType) = item else { return }
        self.colorTypeStream = Observable.just(colorType)
        Observable.just(colorType.rawValue)
            .bind(to: self.rx.colorNameLabelText)
            .disposed(by: disposeBag)
    }
    
    func bind(_ viewModel: SliderViewModelProtocol) {
        selectedColorSubject
            .withLatestFrom(colorTypeStream) { color, colorType in
                SliderColor(colorType: colorType, color: color)
            }
            .distinctUntilChanged()
            .bind(onNext: { [weak viewModel] color in
                viewModel?.colorCellDidSelected(color)
            })
            .disposed(by: disposeBag)
    }
}
