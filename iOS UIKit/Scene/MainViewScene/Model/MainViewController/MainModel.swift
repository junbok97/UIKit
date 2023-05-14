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
    
    // 기본 데이터
    private let objects: [ObjectSectionModel] = [
        ObjectSectionModel(
            sectionHeader: .label,
            items: [
                Object(type: .label)
            ]
        ),
        ObjectSectionModel(
            sectionHeader: .button,
            items: [
                Object(type: .button)
            ]
        ),
        ObjectSectionModel(
            sectionHeader: .system,
            items: [
                Object(type: .sfSymbols)
            ]
        )
    ]
    
    lazy var datas = BehaviorSubject<[ObjectSectionModel]>(value: self.objects)
    
    func searchObject(_ title: String?) {
        guard let title = title, title != "" else {
            datas.onNext(objects)
            return
        }
        
        let newSectionModel = objects.compactMap { sectionModel in
            let newobjects = sectionModel.items.filter { object in
                object.title.range(of: title, options: .caseInsensitive) != nil
            }
            return newobjects.count == 0 ? nil : ObjectSectionModel(sectionHeader: sectionModel.sectionHeader, items: newobjects)
        }
        
        datas.onNext(newSectionModel)
    }
    
}
