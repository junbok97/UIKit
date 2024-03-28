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

protocol MainViewModelProtocol: ViewModelProtocol {
    var cellData: Driver<[ObjectSectionModel]> { get }
    
    func dataSource() -> RxTableViewSectionedReloadDataSource<ObjectSectionModel>
    func searchObject(_ title: String?)
}

final class MainViewModel: MainViewModelProtocol {
    
    private let disposeBag = DisposeBag()
    
    let objectListDataStream = BehaviorRelay<[ObjectSectionModel]>(value: ObjectListData.objectListDatas)
    
    // ViewModel - > View
    let cellData: Driver<[ObjectSectionModel]>
    
    init() {
        cellData = objectListDataStream
            .asDriver(onErrorDriveWith: .empty())
    }
    
    func dataSource() -> RxTableViewSectionedReloadDataSource<ObjectSectionModel> {
        let dataSource = RxTableViewSectionedReloadDataSource<ObjectSectionModel> { _, tableView, indexPath, item in
            let cell = ObjectListCell.dequeueReusableCell(tableView: tableView, indexPath: indexPath)
            cell.setup(objectType: item)
            return cell
        }
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].sectionHeader.rawValue
        }
        
        return dataSource
    }
    
    func searchObject(_ title: String?) {
        objectListDataStream.accept(MainModel.searchObject(title))
    }
    
}
