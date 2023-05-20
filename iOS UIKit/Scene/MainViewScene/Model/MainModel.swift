//
//  MainModel.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/05/04.
//

import Foundation
import RxDataSources
import RxSwift

final class MainModel {
    
    let objectListDataStream = BehaviorSubject<[ObjectSectionModel]>(value: ObjectListData.objectListDatas)
    
    func searchObject(_ title: String?) {
        guard let title = title, title != "" else {
            objectListDataStream.onNext(ObjectListData.objectListDatas)
            return
        }
        
        let newSectionModel = ObjectListData.objectListDatas.compactMap { sectionModel in
            let newobjects = sectionModel.items.filter { objectType in
                objectType.rawValue.range(of: title, options: .caseInsensitive) != nil
            }
            return newobjects.count == 0 ? nil : ObjectSectionModel(sectionHeader: sectionModel.sectionHeader, items: newobjects)
        }
        objectListDataStream.onNext(newSectionModel)
    }
    
}
