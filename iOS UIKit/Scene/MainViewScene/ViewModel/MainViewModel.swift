//
//  MainViewModel.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/05/04.
//

import Foundation
import RxSwift
import RxDataSources
import RxCocoa

final class MainViewModel {
    
    let disposeBag = DisposeBag()
    
    // View -> ViewModel
    let searchObject = PublishRelay<String?>()
    
    // ViewModel - > View
    let cellData: Driver<[ObjectSectionModel]>
    
    init() {
        let mainModel = MainModel()
        
        cellData = mainModel.datas
            .asDriver(onErrorDriveWith: .empty())
        
        searchObject
            .subscribe(onNext: {
                mainModel.searchObject($0)
            })
            .disposed(by: disposeBag)
    }
    
    func dataSource() -> RxTableViewSectionedReloadDataSource<ObjectSectionModel> {
        let dataSource = RxTableViewSectionedReloadDataSource<ObjectSectionModel> { _, tableView, indexPath, item in
            let cell = ObjectListCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(object: item)
            return cell
        }
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].sectionHeader.rawValue
        }
        
        return dataSource
    }
    
}
