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
        guard case let .toggle(type: type) = item else { return }
        setupLabelText(type.rawValue)
        self.toggleStream = Observable.just(type)
    }
    
    func bind(_ viewModel: StepperViewModelProtocol) {
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
