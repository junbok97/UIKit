//
//  StackViewModel.swift
//  iOS UIKit
//
//  Created by 이준복 on 2023/06/03.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol StackViewViewModelProtocl: ViewModelProtocol {
    func colorCellDidSelected(_ stackViewColor: StackViewColor)
    func stackViewSettingListDataSource() -> RxTableViewSectionedReloadDataSource<StackViewSettingListSectionModel>

}

final class StackViewViewModel: StackViewViewModelProtocl {
    
}

extension StackViewViewModel {
    func colorCellDidSelected(_ stackViewColor: StackViewColor) {
        
    }
    
    func stackViewSettingListDataSource() -> RxTableViewSectionedReloadDataSource<StackViewSettingListSectionModel> {
        RxTableViewSectionedReloadDataSource<StackViewSettingListSectionModel> {  dataSource, tableView, indexPath, sectionModelItem in
            StackViewModel.makeCell(
                dataSource[indexPath.section].sectionHeader,
                self,
                tableView,
                indexPath,
                sectionModelItem
            )
        } // RxTableViewSectionedReloadDataSource
    }
}
