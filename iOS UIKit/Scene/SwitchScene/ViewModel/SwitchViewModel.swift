//
//  SwitchViewModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/22.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class SwitchViewModel {
    
    private let disposeBag = DisposeBag()
    
    // View -> ViewModel
    let onTintColorDidSeleted = BehaviorRelay<UIColor>(value: .systemGreen)
    let thumbTintColorDidSeleted = BehaviorRelay<UIColor>(value: .white)
    let backgroundColorDidSeleted = BehaviorRelay<UIColor>(value: .secondarySystemBackground)
    let isOnDidChanged = BehaviorRelay<Bool>(value: true)
    
    // ViewModel -> View
    let targetOnTintColor: Driver<UIColor>
    let targetThumbTintColor: Driver<UIColor>
    let targetBackgroundColor: Driver<UIColor>
    
    let codeCellCodeLabelText: Driver<String>
    let switchSettingListcellDatas: Driver<[SwitchSettingListSectionModel]>
    
    let switchSettingCodeText = BehaviorRelay<String>(value: SwitchViewControllerConstants.defaultSwitchCode)
    
    private let switchModel = SwitchModel()
    
    init() {
        switchSettingListcellDatas = Observable.just(SwitchSettingListData.settingListDatas)
            .asDriver(onErrorDriveWith: .empty())
        
        codeCellCodeLabelText = switchSettingCodeText
            .asDriver(onErrorDriveWith: .empty())
        
        targetOnTintColor = onTintColorDidSeleted
            .asDriver(onErrorDriveWith: .empty())
        
        targetThumbTintColor = thumbTintColorDidSeleted
            .asDriver(onErrorDriveWith: .empty())
        
        targetBackgroundColor = backgroundColorDidSeleted
            .asDriver(onErrorDriveWith: .empty())
        
        switchSettingToCode()
    }
    
    func colorCellDidSelected(_ switchColor: SwitchColor) {
        switch switchColor.colorType {
        case .onTintColor:
            onTintColorDidSeleted.accept(switchColor.color)
        case .thumbTintColor:
            thumbTintColorDidSeleted.accept(switchColor.color)
        case .backgroundColor:
            backgroundColorDidSeleted.accept(switchColor.color)
        }
    }
    
    func switchSettingListDataSource() -> RxTableViewSectionedReloadDataSource<SwitchSettingListSectionModel> {
         RxTableViewSectionedReloadDataSource<SwitchSettingListSectionModel> { dataSource, tableView, indexPath, sectionModelItem in
            SwitchModel.makecell(
                dataSource[indexPath.section].sectionHeader,
                self,
                tableView,
                indexPath,
                sectionModelItem
            )
        }
    }
    
    func switchSettingToCode() {
        Observable
            .combineLatest(
                isOnDidChanged,
                onTintColorDidSeleted,
                thumbTintColorDidSeleted,
                backgroundColorDidSeleted
            ).map(switchModel.codeLabelText)
            .bind(to: switchSettingCodeText)
            .disposed(by: disposeBag)
    }
    
    deinit {
        print("SwitchViewModel Deinit")
    }
}
