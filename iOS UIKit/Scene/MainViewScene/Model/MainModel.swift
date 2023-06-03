//
//  MainModel.swift
//  UIKit-Test
//
//  Created by 이준복 on 2023/05/04.
//

import Foundation
import RxDataSources
import RxSwift

protocol MainModelProtocol: ModelProtocol {
    static func searchObject(_ title: String?) -> [ObjectSectionModel]
}

final class MainModel: MainModelProtocol {
    static func searchObject(_ title: String?) -> [ObjectSectionModel] {
        guard let title = title, title != "" else {
            return ObjectListData.objectListDatas
        }
        
        let newSectionModel = ObjectListData.objectListDatas.compactMap { sectionModel in
            let newobjects = sectionModel.items.filter { objectType in
                objectType.rawValue.range(of: title, options: .caseInsensitive) != nil
            }
            return newobjects.count == 0 ? nil : ObjectSectionModel(sectionHeader: sectionModel.sectionHeader, items: newobjects)
        }
        
        return newSectionModel
    }
}
