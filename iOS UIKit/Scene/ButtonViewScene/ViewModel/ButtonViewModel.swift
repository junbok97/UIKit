//
//  ButtonViewModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/05/14.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

final class ButtonViewModel {
    
    // View -> ViewModel
    
    // ViewModel -> View
    let buttonSettingListCellDatas: Driver<[ButtonSettingListSectionModel]>
    
    init() {
        let buttonModel = ButtonModel()
        buttonSettingListCellDatas = buttonModel.buttonSettingListCellDatas
            .asDriver(onErrorDriveWith: .empty())
    }
    
    func buttonSettingListDataSource() -> RxTableViewSectionedReloadDataSource<ButtonSettingListSectionModel> {
        
        let dataSource = RxTableViewSectionedReloadDataSource<ButtonSettingListSectionModel> { dataSource, tableView, indexPath, sectionModelItem in
            
            ButtonModel.makeCell(
                dataSource[indexPath.section].sectionHeader,
                self,
                tableView,
                indexPath,
                sectionModelItem
            )   
        }
        
        return dataSource
    }
    
    
}
