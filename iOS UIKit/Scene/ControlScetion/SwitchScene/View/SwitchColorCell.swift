//
//  SwitchColorCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import Foundation
import RxSwift

final class SwitchColorCell: DefaultColorCell, SwitchSettingListCellProtocol {
    static override var cellId: String {
        SwitchColorCellConstants.cellId
    }
    
    private var colorTypeStream: Observable<SwitchColorType> = Observable.just(.onTintColor)
    
    func setup(_ item: SwitchSettingListItemType) {
        guard case let .color(colorType: colorType) = item else { return }
        self.colorTypeStream = Observable.just(colorType)
        Observable.just(colorType.rawValue)
            .bind(to: self.rx.colorNameLabelText)
            .disposed(by: disposeBag)
    }
    
    func bind(_ viewModel: SwitchViewModelProtocol) {
        selectedColorSubject
            .withLatestFrom(colorTypeStream) { color, colorType in
                SwitchColor(colorType: colorType, color: color)
            }
            .distinctUntilChanged()
            .bind(onNext: { [weak viewModel] switchColor in
                viewModel?.colorCellDidSelected(switchColor)
            })
            .disposed(by: disposeBag)
    }
}
