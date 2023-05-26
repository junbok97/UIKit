//
//  StepperToggleCell.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/24.
//

import UIKit
import RxSwift
import RxCocoa

final class StepperToggleCell: DefaultSwitchCell, StepperSettingListCellProtocol {
    override class var cellId: String {
        StepperToggleCellConstants.cellId
    }
    
    private var toggleStream: Observable<StepperToggleType> = Observable.just(.autorepeat)
    
    func setup(_ item: StepperSettingListItemType) {
        guard case let .toggle(toggleType: toggleType) = item else { return }
        setupLabelText(toggleType.rawValue)
        self.toggleStream = Observable.just(toggleType)
    }
    
    func bind(_ viewModel: StepperViewModel) {
        switchToggle.rx.isOn
            .withLatestFrom(toggleStream) { value, toggleType in
                StepperToggle(toggleType: toggleType, value: value)
            }
            .bind(onNext: { [weak viewModel] toggle in
                viewModel?.toggleIsOn(toggle)
            })
            .disposed(by: disposeBag)
    }
}
