//
//  StepperViewModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/23.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

protocol StepperViewModelProtocol: ViewModelProtocol {
    // View -> ViewModel
    var targetStepperDidChanged: PublishRelay<Double> { get }
    
    var stepValueDidChanged: BehaviorRelay<Double> { get }
    var maximumValueDidChanged: BehaviorRelay<Double> { get }
    var minimumValueDidChanged: BehaviorRelay<Double> { get }
    var autorepeatIsOn: BehaviorRelay<Bool> { get }
    var wrapIsOn: BehaviorRelay<Bool> { get }
    
    var stepperSettingCodeText: BehaviorRelay<String> { get }
    
    // ViewModel -> View
    var targetVauleLabelText: Driver<String> { get }
    var codeCellCodeLabelText: Driver<String> { get }
    var stepperSettingListCellDatas: Driver<[StepperSettingListSectionModel]> { get }
    
    var targetStepValue: Driver<Double> { get }
    var targetMaximumValue: Driver<Double> { get }
    var targetMinimumValue: Driver<Double> { get }
    var targetAutorepeat: Driver<Bool> { get }
    var targetWrap: Driver<Bool> { get }
    
    func stepperSettingToCode()
    func toggleIsOn(_ toggle: StepperToggle)
    func valueCellDidChanged(_ stepperValue: StepperValue)
    func stepperSettingListDataSource() -> RxTableViewSectionedReloadDataSource<StepperSettingListSectionModel>
}

final class StepperViewModel: StepperViewModelProtocol {
    
    private let disposebag = DisposeBag()
    
    // View -> ViewModel
    let targetStepperDidChanged = PublishRelay<Double>()
    
    let stepValueDidChanged = BehaviorRelay<Double>(value: StepperViewControllerConstants.defaulSteppertValue)
    let maximumValueDidChanged = BehaviorRelay<Double>(value: StepperViewControllerConstants.defaultStepperMaximumValue)
    let minimumValueDidChanged = BehaviorRelay<Double>(value: StepperViewControllerConstants.defaultStepperMinimumValue)
    let autorepeatIsOn = BehaviorRelay<Bool>(value: false)
    let wrapIsOn = BehaviorRelay<Bool>(value: false)
    
    let stepperSettingCodeText = BehaviorRelay<String>(value: StepperViewControllerConstants.defaultStepperCode)
    
    // ViewModel -> View
    let targetVauleLabelText: Driver<String>
    let codeCellCodeLabelText: Driver<String>
    let stepperSettingListCellDatas: Driver<[StepperSettingListSectionModel]>
    
    let targetStepValue: Driver<Double>
    let targetMaximumValue: Driver<Double>
    let targetMinimumValue: Driver<Double>
    let targetAutorepeat: Driver<Bool>
    let targetWrap: Driver<Bool>
    
    init() {
        
        stepperSettingListCellDatas = Observable.just(StepperSettingListData.settingListData)
            .asDriver(onErrorDriveWith: .empty())
        
        targetVauleLabelText = targetStepperDidChanged
            .map {
                String(format: "%lf", $0)
            }
            .asDriver(onErrorDriveWith: .empty())
        
        targetStepValue = stepValueDidChanged
            .filter { $0 != 0 }
            .asDriver(onErrorDriveWith: .empty())
        
        targetMaximumValue = maximumValueDidChanged
            .asDriver(onErrorDriveWith: .empty())
        
        targetMinimumValue = minimumValueDidChanged
            .asDriver(onErrorDriveWith: .empty())
        
        targetAutorepeat = autorepeatIsOn
            .asDriver(onErrorDriveWith: .empty())
        
        targetWrap = wrapIsOn
            .asDriver(onErrorDriveWith: .empty())
        
        codeCellCodeLabelText = stepperSettingCodeText.asDriver(onErrorDriveWith: .empty())
        
        stepperSettingToCode()
    }
    

   deinit {
       print("StepperViewModel Deinit")
   }
   
}

extension StepperViewModel {
    func stepperSettingListDataSource() -> RxTableViewSectionedReloadDataSource<StepperSettingListSectionModel> {
        RxTableViewSectionedReloadDataSource<StepperSettingListSectionModel> { dataSource, tableView, indexPath, sectionModelItem in
           StepperModel.makeCell(
               dataSource[indexPath.section].sectionHeader,
               self,
               tableView,
               indexPath,
               sectionModelItem
           )
       }
   }
    
    func stepperSettingToCode() {
        Observable
            .combineLatest(
                autorepeatIsOn,
                wrapIsOn,
                stepValueDidChanged,
                minimumValueDidChanged,
                maximumValueDidChanged
            ).map(StepperModel.codeLabelText)
            .bind(to: stepperSettingCodeText)
            .disposed(by: disposebag)
    }
    
    func valueCellDidChanged(_ stepperValue: StepperValue) {
        switch stepperValue.valueType {
        case .step:
            stepValueDidChanged.accept(stepperValue.value)
        case .maximum:
            maximumValueDidChanged.accept(stepperValue.value)
        case .minimum:
            minimumValueDidChanged.accept(stepperValue.value)
        }
    }
    
    func toggleIsOn(_ toggle: StepperToggle) {
        switch toggle.toggleType {
        case .autorepeat:
            autorepeatIsOn.accept(toggle.value)
        case .wrap:
            wrapIsOn.accept(toggle.value)
        }
    }
    
}
