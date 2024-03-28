//
//  StackViewColorCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import Foundation
import RxSwift

final class StackViewColorCell: DefaultColorCell, StackViewSettingListCellProtocol {
    
    static override var cellId: String {
        StackViewColorCellConstants.cellId
    }
    
    private var colorTypeStream: Observable<StackViewColorType> = Observable.just(.tintColor)
    
    func setup(_ item: StackViewSettingListItemType) {
        guard case let .color(type: type)  = item else {
            return
        }
        self.colorTypeStream = Observable.just(type)
        Observable.just(type.rawValue)
            .bind(to: self.rx.colorNameLabelText)
            .disposed(by: disposeBag)
    }
    
    func bind(_ viewModel: StackViewViewModel) {
        selectedColorSubject
            .withLatestFrom(colorTypeStream) { color, colorType in
                StackViewColor(colorType: colorType, color: color)
            }
            .distinctUntilChanged()
            .bind(onNext: { [weak viewModel] color in
                viewModel?.colorCellDidSelected(color)
            })
            .disposed(by: disposeBag)
    }
    
}
