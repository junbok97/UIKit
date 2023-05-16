//
//  ButtonViewModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class ButtonViewModel {
    
    private let disposeBag = DisposeBag()
    
    let buttonModel = ButtonModel()
    let buttonConfigurationModel = ButtonConfigurationViewModel()
    
    // View -> ViewModel
    let colorCellSelected = PublishRelay<ObjectColor>()
    
    // ViewModel -> View
    let buttonSettingListCellDatas: Driver<[ButtonSettingListSectionModel]>
    
    let targetButtonConfiguration: Driver<UIButton.Configuration>
    let targetColor: Driver<ObjectColor>
    
    init() {
        buttonSettingListCellDatas = Observable.just(ButtonSettingListData.settingListDatas)
            .asDriver(onErrorDriveWith: .empty())
        targetButtonConfiguration = buttonConfigurationModel.buttonConfigurationDidChanged
            .asDriver(onErrorDriveWith: .empty())
        
        targetColor = colorCellSelected
            .asDriver(onErrorDriveWith: .empty())
    }
    
    func colorCellDidSelected(_ objectColor: ObjectColor) {
        colorCellSelected.accept(objectColor)
        buttonConfigurationModel.colorCellDidSelected(objectColor)
    }
    
    func buttonSettingListItemSelected(_ itemType: ButtonSettingListItemType) {
        buttonConfigurationModel.buttonSettingListItemSelected(itemType)
    }
    
    func buttonSettingListDataSource() -> RxTableViewSectionedReloadDataSource<ButtonSettingListSectionModel> {
        
        let dataSource = RxTableViewSectionedReloadDataSource<ButtonSettingListSectionModel> { [weak self] dataSource, tableView, indexPath, sectionModelItem in
            guard let self = self else { fatalError("ButtonViewModel Nil") }
            return self.buttonModel.makeCell(
                dataSource[indexPath.section].sectionHeader,
                self,
                tableView,
                indexPath,
                sectionModelItem
            )
        } // RxTableViewSectionedReloadDataSource
        
        return dataSource
    }
    
    deinit {
        print("ButtonViewModel Deinit")
    }
}
